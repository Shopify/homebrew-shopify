class EchoNginxModule < Formula
  desc "ngx_echo - Brings echo, sleep, time, exec and more shell-style goodies to Nginx config file."
  homepage "https://github.com/openresty/echo-nginx-module"
  url "https://github.com/openresty/echo-nginx-module/archive/v0.61.tar.gz"
  version "v0.61"
  sha256 "2e6a03032555f5da1bdff2ae96c96486f447da3da37c117e0f964ae0753d22aa"

  depends_on "lua-nginx-module"

  def install
    (share+"echo-nginx-module").install Dir["*"]
  end
end
