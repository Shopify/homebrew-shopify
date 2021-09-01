# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version "2.1.5"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-server-darwin-amd64"
    sha256 "3f3875d0e5873fc47213f2c758b8c9706d94b2c88ad061816216d59529916620"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-server-darwin-arm64"
    sha256 "b815f7d98deb8e17bc92a5a30c1b7fb9dbba4efbf28278faf9c5e81882c77e89"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-server-linux-amd64"
    sha256 "076e8b510fa7901bf244ab5407d120300dab68767637b599a109eacd15ba7087"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-server-linux-arm64"
    sha256 "8b5edc3a213239a1fd9a86612a0f87f5a1e3d2a382e0fba7f4ffe1389de887bd"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-cli-darwin-amd64"
      sha256 "94bca471e5f11aab79e780a667b8e56cc9d6b934a6f83610b512e1762507231e"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-cli-darwin-arm64"
      sha256 "0ef88ea04ce5f28dd84a84f77a5952035a7baa8d1acfc25d6491b57845602022"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-cli-linux-amd64"
      sha256 "4a7cd5ddae87eb09d5db5be09e05e62aa91b69604ac98e3789732bdada04ccf6"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.5/toxiproxy-cli-linux-arm64"
      sha256 "4bb45553ddabcf3a6c544666e9cbd73ba71c354d085133b30a97efa58500faf9"
    end
  end

  test do
    resource("cli").stage do
      assert_match "toxiproxy-cli version 2.1.5", shell_output("#{bin}/toxiproxy-cli --version")
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
