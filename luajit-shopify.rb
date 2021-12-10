class LuajitShopify < Formula
  desc "Just-In-Time Compiler (JIT) for the Lua programming language"
  homepage "http://luajit.org/luajit.html"
  url "http://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz"
  sha256 "1ad2e34b111c802f9d0cdf019e986909123237a28c746b21295b63c9e785d9c3"
  head "http://luajit.org/git/luajit-2.0.git"

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any, arm64_monterey: "90dafd36b7efaf2ec8e5a9273b28584396220b55fd69e50911b8afa21a1e3a7a"
    sha256 cellar: :any, monterey: "aec5523c766b1c75e50f9b105b9e165a5cb991f8020a42106f5a11c4cc161a7e"
  end

  conflicts_with "luajit", :because => "shopify uses luajit 2.1. `brew uninstall luajit` first"

  deprecated_option "enable-debug" => "with-debug"

  option "with-debug", "Build with debugging symbols"
  option "with-52compat", "Build with additional Lua 5.2 compatibility"

  def install
    # 1 - Override the hardcoded gcc.
    # 2 - Remove the "-march=i686" so we can set the march in cflags.
    # Both changes should persist and were discussed upstream.
    inreplace "src/Makefile" do |f|
      f.change_make_var! "CC", ENV.cc
      f.change_make_var! "CCOPT_x86", ""
    end

    # Per https://luajit.org/install.html: If MACOSX_DEPLOYMENT_TARGET
    # is not set then it's forced to 10.4, which breaks compile on Mojave.
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version

    args = %W[PREFIX=#{prefix}]

    # Build with 64-bit support
    args << "XCFLAGS=-DLUAJIT_ENABLE_GC64" if build.head?

    system "make", "amalg", *args
    system "make", "install", *args

    # Unstable branch doesn't install symlink for luajit.
    # This breaks tools like `luarock` who requires the `luajit` bin to be present.
    bin.install_symlink Dir[bin/"luajit-*"].first => "luajit" if build.head?

    # LuaJIT doesn't automatically symlink unversioned libraries:
    # https://github.com/Homebrew/homebrew/issues/45854.
    lib.install_symlink lib/"libluajit-5.1.dylib" => "libluajit.dylib"
    lib.install_symlink lib/"libluajit-5.1.a" => "libluajit.a"

    # Fix path in pkg-config so modules are installed
    # to permanent location rather than inside the Cellar.
    inreplace lib/"pkgconfig/luajit.pc" do |s|
      s.gsub! "INSTALL_LMOD=${prefix}/share/lua/${abiver}",
              "INSTALL_LMOD=#{HOMEBREW_PREFIX}/share/lua/${abiver}"
      s.gsub! "INSTALL_CMOD=${prefix}/${multilib}/lua/${abiver}",
              "INSTALL_CMOD=#{HOMEBREW_PREFIX}/${multilib}/lua/${abiver}"
      unless build.head?
        s.gsub! "Libs:",
                "Libs: -pagezero_size 10000 -image_base 100000000"
      end
    end

    # Having an empty Lua dir in lib/share can mess with other Homebrew Luas.
    %W[#{lib}/lua #{share}/lua].each { |d| rm_rf d }
  end

  test do
    system "#{bin}/luajit", "-e", <<~EOS
      local ffi = require("ffi")
      ffi.cdef("int printf(const char *fmt, ...);")
      ffi.C.printf("Hello %s!\\n", "#{ENV["USER"]}")
    EOS
  end
end
