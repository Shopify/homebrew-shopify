class LuaUpstreamNginxModule < Formula
  desc "Nginx C module to expose Lua API to ngx_lua for Nginx upstreams"
  homepage "https://github.com/openresty/lua-upstream-nginx-module"
  url "https://github.com/openresty/lua-upstream-nginx-module/archive/v0.07.tar.gz"
  sha256 "2a69815e4ae01aa8b170941a8e1a10b6f6a9aab699dee485d58f021dd933829a"
  head "https://github.com/openresty/lua-upstream-nginx-module.git"

  bottle :unneeded

  depends_on "lua-nginx-module"

  def install
    (share+"lua-upstream-nginx-module").install Dir["*"]
  end
end
