# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  app_version = "2.1.7"
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version app_version

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-amd64"
    sha256 "cb348eeefcb7a0b6cabbdb1ef00d9fb9f3b3002c2a13e1dc327c76a9fef4976f"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-arm64"
    sha256 "f4d2fa3f3677fe78fcfbada6581eefc79eb1d76a10270a3c605bd29b7b7a16b1"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-amd64"
    sha256 "dedb052f2e367dfb7597375a7077acfe72d4ef541e025b37bad43051c9f6de35"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-arm64"
    sha256 "0f62adfa40b1b160b22891bc255e16935c25ff29d056d6213b35ec4e72ccb6a5"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-amd64"
      sha256 "0519980f33f2ab242148b44a093d547a536c9b0aacc9d19b84470db33b528267"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-arm64"
      sha256 "5878060d77e2332047fcb8a494ca6dafbb1791c73d34dd11f9d2e05b1bb7c54a"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-amd64"
      sha256 "805e03f589aad0e3637b2cf973ef9d3cf73cc1fd55473c696d95569f9368eab6"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-arm64"
      sha256 "250e6336d2fc29a982d78f62438e4c5195dab40825e9b315b08d8d9e95ad4c2f"
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

  plist_options manual: "toxiproxy"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/toxiproxy-server</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end
end
