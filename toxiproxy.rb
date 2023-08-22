# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  app_version = "2.6.0"
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version app_version

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-amd64"
    sha256 "7df7a295adaeddd8654be00cb5fa6363100d745c151e7e42649a554767c50c0c"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-arm64"
    sha256 "cfc033ef0e1c402f1c84789a88a7acd79b4c421f89839458a8d21ee8bc69801f"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-amd64"
    sha256 "bf693bf8d7bdfd39d71f0a1a87fff5895db6d56565d06f3586aa9b271d1dc659"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-arm64"
    sha256 "6cd8d681d3c39ffa59877eb56a29d4887876d4740ac07afbb26e1aa3c3ba7dbe"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-amd64"
      sha256 "6e3bc4fcf127b8cc2c6dd306e3157fb16579c510b725eee0a1ba8f8288b3faff"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-arm64"
      sha256 "c45b7a2ad98536e7d5b55ccf70b45b0f2b9128e7892c4304ca8d7e4d786b2235"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-amd64"
      sha256 "186fc2cc4fc9a077a2bcb3bbed31f974f1f4ff19d7009148b68b442b06796c17"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-arm64"
      sha256 "20959bc0c5ee02d225d477d5db372b8fe1b6142381b82272c1ba65efcee7c39f"
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
