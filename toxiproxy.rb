# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  app_version = "2.10.0"
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version app_version

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-amd64"
    sha256 "147a9da841eb314a1de15cc095fa89ebdc12e3b5e61cbaf65db7a029d14984b7"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-arm64"
    sha256 "e2962afe3a274b2d5f58db3da2fd8513b908fe81a3ba35d5423e6ff66c88da10"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-amd64"
    sha256 "6f1e04c50fb92ad297b5a8418baa6916f8f00de5517031c509f568539781be04"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-arm64"
    sha256 "3dacbd1b14c1df1b6f961cec6546960b7b356ac6d6e2615d58bac40fa3ceef4c"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-amd64"
      sha256 "8f82e36b669bf2e391c38ffa55d1686b3154d11b3cfe56fba4c5b2d97bc44166"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-arm64"
      sha256 "0ed3b2831396c2c08cedcbbdf0086e5cd826ab90f27c6335ea35008dd539406b"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-amd64"
      sha256 "802f6a10ad5dfa3d21b2f8238bb16cd88ad92e6b7b9da391591b0ef7d91691e9"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-arm64"
      sha256 "cb7992cb9ead8fa2fb3d8d77a40668f5161f0d55d888d9807f40da4876d978ce"
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
