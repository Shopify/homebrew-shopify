class LuaNginxInternalsNginxModule < Formula
  desc "Nginx C module to expose Lua API to access nginx internals"
  homepage "https://github.com/openresty/lua-upstream-nginx-module"
  head "https://github.com/shopify/lua-nginx-internals-nginx-module.git"

  bottle :unneeded

  depends_on "lua-nginx-module"

  def install
    (share+"lua-nginx-internals-nginx-module").install Dir["*"]
  end
end
