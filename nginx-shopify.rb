class NginxShopify < Formula
  desc "HTTP(S) server, reverse proxy, IMAP/POP3 proxy server"
  homepage "http://nginx.org/"
  url "https://nginx.org/download/nginx-1.13.4.tar.gz"
  sha256 "de21f3c49ba65c611329d8759a63d72e5fcf719bc6f2a3270e2541348ef1fbba"
  head "http://hg.nginx.org/nginx/", :using => :hg

  conflicts_with "nginx", :because => "shopify has a custom nginx build. `brew uninstall nginx` first"

  def self.nginx_modules
    {
      "ngx-devel-kit" => :build,
      "lua-nginx-module" => :build,
      "lua-upstream-nginx-module" => :build,
      "lua-nginx-internals-nginx-module" => :build,
      "echo-nginx-module" => :build
    }
  end

  depends_on "pcre"
  depends_on "geoip"
  depends_on "openssl"
  depends_on "luajit-shopify"
  nginx_modules.each { |m, v| depends_on m => v }

  # This patch can be viewed and edited via https://gist.github.com/marc-barry/63b7bc9481d73211a895efcb1b98b22e
  patch do
    url "https://gist.githubusercontent.com/marc-barry/63b7bc9481d73211a895efcb1b98b22e/raw/74f983ca4ab3974f7bcd059de9a6066cf5d3c430/openresty-ssl_cert_cb_yield.patch"
    sha256 "73f29eb281e7da95f4db3b33e44d318e685fef7328e79c6c01a7393f88cef788"
  end

  # This patch can be viewed and edited via https://gist.github.com/marc-barry/cdf0eba34c02521ae9a3af27158b6ff9
  patch do
    url "https://gist.githubusercontent.com/marc-barry/cdf0eba34c02521ae9a3af27158b6ff9/raw/599c35039320b681bf2b64af9061f0dcbf64a8e0/vary_header_length.patch"
    sha256 "b7360a6c4a90af321e235611cc88bc14f947b2bfe75cf9aaaaaced576fec3ed4"
  end

  resource "lua-resty-core" do
    url "https://github.com/openresty/lua-resty-core/archive/v0.1.12.tar.gz"
    sha256 "a7945e57de5216838c34bf99f547cc17b63afc68668904dfc4fc86280a217236"
  end

  env :userpaths
  skip_clean "logs"

  def install
    pcre = Formula["pcre"]
    openssl = Formula["openssl"]
    cc_opt = "-I#{HOMEBREW_PREFIX}/include -I#{pcre.include} -I#{openssl.include}"
    ld_opt = "-L#{HOMEBREW_PREFIX}/lib -L#{pcre.lib} -L#{openssl.lib}"

    args = %W[
      --prefix=#{prefix}
      --with-http_ssl_module
      --with-http_realip_module
      --with-http_stub_status_module
      --with-http_geoip_module
      --with-http_v2_module
      --with-stream
      --with-ipv6
      --with-pcre
      --with-debug
      --sbin-path=#{bin}/nginx
      --with-cc-opt=#{cc_opt}
      --with-ld-opt=#{ld_opt}
      --conf-path=#{etc}/nginx/nginx.conf
      --pid-path=#{var}/run/nginx.pid
      --lock-path=#{var}/run/nginx.lock
      --http-client-body-temp-path=#{var}/run/nginx/client_body_temp
      --http-proxy-temp-path=#{var}/run/nginx/proxy_temp
      --http-fastcgi-temp-path=#{var}/run/nginx/fastcgi_temp
      --http-uwsgi-temp-path=#{var}/run/nginx/uwsgi_temp
      --http-scgi-temp-path=#{var}/run/nginx/scgi_temp
      --http-log-path=#{var}/log/nginx/access.log
      --error-log-path=#{var}/log/nginx/error.log
    ]

    self.class.nginx_modules.each_key do |m|
      args << "--add-module=#{HOMEBREW_PREFIX}/share/#{m}"
    end

    luajit_path = `brew --prefix luajit-shopify`.chomp
    ENV["LUAJIT_LIB"] = "#{luajit_path}/lib"
    ENV["LUAJIT_INC"] = "#{luajit_path}/include/luajit-2.1"

    if build.head?
      system "./auto/configure", *args
    else
      system "./configure", *args
    end

    system "make", "install"
    if build.head?
      man8.install "docs/man/nginx.8"
    else
      man8.install "man/nginx.8"
    end

    (etc/"nginx/servers").mkpath
    (var/"run/nginx").mkpath

    resource("lua-resty-core").stage do
      (lib/"lua").install Dir['lua-resty-core', 'lib']
    end
  end

  def post_install
    # nginx's docroot is #{prefix}/html, this isn't useful, so we symlink it
    # to #{HOMEBREW_PREFIX}/var/www. The reason we symlink instead of patching
    # is so the user can redirect it easily to something else if they choose.
    html = prefix/"html"
    dst = var/"www"

    if dst.exist?
      html.rmtree
      dst.mkpath
    else
      dst.rmtree if dst.symlink? && !File.exist?(dst)
      dst.dirname.mkpath
      html.rename(dst)
    end

    prefix.install_symlink dst => "html"

    # for most of this formula's life the binary has been placed in sbin
    # and Homebrew used to suggest the user copy the plist for nginx to their
    # ~/Library/LaunchAgents directory. So we need to have a symlink there
    # for such cases
    if rack.subdirs.any? { |d| d.join("sbin").directory? }
      sbin.install_symlink bin/"nginx"
    end
  end
end
