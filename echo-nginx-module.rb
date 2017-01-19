class EchoNginxModule < Formula
  desc "ngx_echo - Brings echo, sleep, time, exec and more shell-style goodies to Nginx config file."
  homepage "https://github.com/openresty/echo-nginx-module"
  url "https://github.com/openresty/echo-nginx-module/archive/v0.60.tar.gz"
  version "v0.60"
  sha256 "1077da2229ac7d0a0215e9e6817e297c10697e095010d88f1adbd1add1ce9f4e"
  bottle :unneeded

  depends_on "lua-nginx-module"

  def install
    (share+"echo-nginx-module").install Dir["*"]
  end
end
