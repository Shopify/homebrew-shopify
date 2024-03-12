# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  app_version = "2.9.0"
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version app_version

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-amd64"
    sha256 "dc87322e2a2bf8f021345fd80dea8e2ffbb2d87ee9a18c72b31ba2083fbe77ba"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-arm64"
    sha256 "105f544c5c4c5022673201673deda77960bba2aadea4fd086cac754b61de080c"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-amd64"
    sha256 "8468ff159d953f2cd118232b658f5ee867aa980d2358379b493a395367be5d32"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-arm64"
    sha256 "21b3aa2e0393fb9c2f52c2332a8579d279f864abf9d48414d9039c691d3c2284"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-amd64"
      sha256 "101c15b8c9871919c0494d6b0fa67707d835ca96bb5d20a06b58e23baf35b94c"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-arm64"
      sha256 "b07e679e60a099b2e52e3b59ddc59694ebb921532576046f82c0616fd11b6f85"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-amd64"
      sha256 "02604f704ee2a080dc23dd01a8e15c56c8a98e0b5597c042a6d60e3015730782"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-arm64"
      sha256 "3b6c4218eb5fd8dc2d01f63749afa7e1fd9a81d3104fd8332142595b62d4d0df"
    end
  end

  test do
    resource("cli").stage do
      assert_match "toxiproxy-cli version #{app_version}", shell_output("#{bin}/toxiproxy-cli --version")
    end
  end

  def install
    host_os = OS.mac? ? "darwin" : "linux"
    host_arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    platform = "#{host_os}-#{host_arch}"

    bin.install "toxiproxy-server-#{platform}" => "toxiproxy-server"
    resource("cli").stage do
      bin.install "toxiproxy-cli-#{platform}" => "toxiproxy-cli"
    end
  end

  service do
    run [bin/"toxiproxy-server"]
    keep_alive true
  end
end
