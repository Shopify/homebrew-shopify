# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.0/toxiproxy-server-darwin-amd64"
  sha256 "ae8091cbb5a545e4b5521d197292b648d0347eff1b81999a86ac333957a19a1a"
  version "2.1.0"

  resource "cli" do
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.0/toxiproxy-cli-darwin-amd64"
    sha256 "48e26b3e79fe12be571cdac0661bdcfae883f4968d1411b36cfaf96eafa8090f"
  end

  depends_on :arch => :x86_64

  def install
    bin.install "toxiproxy-server-darwin-amd64" => "toxiproxy-server"
    resource("cli").stage do
      bin.install "toxiproxy-cli-darwin-amd64" => "toxiproxy-cli"
    end
  end

  plist_options :manual => "toxiproxy"

  def plist; <<-EOS.undent
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
