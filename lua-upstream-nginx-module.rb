class LuaUpstreamNginxModule < Formula
  desc "Nginx C module to expose Lua API to ngx_lua for Nginx upstreams"
  homepage "https://github.com/openresty/lua-upstream-nginx-module"
  url "https://github.com/openresty/lua-upstream-nginx-module/archive/v0.05.tar.gz"
  sha256 "0fdfb17083598e674680d8babe944f48a9ccd2af9f982eda030c446c93cfe72b"
  head "https://github.com/openresty/lua-upstream-nginx-module.git"

  bottle :unneeded

  depends_on "lua-nginx-module"

  patch do
    url "https://gist.githubusercontent.com/csfrancis/4b6ca42b9903f4cef1e05580b2dba1d9/raw/4a64ab78362dfd876c9d4c61f2d11426a4d6de32/current_upstream_name.patch"
    sha256 "8a36dcca3ed5c3795eb3b635addc1f267a29bd9dcf72a22c56009f6d7f775124"
  end

  def install
    (share+"lua-upstream-nginx-module").install Dir["*"]
  end
end
