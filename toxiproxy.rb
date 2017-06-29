# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.1/toxiproxy-server-darwin-amd64"
  sha256 "9586e6f75edab06101fcea595e82178af95d50932974519061b66f67379dfd60"
  version "2.1.1"

  resource "cli" do
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.1/toxiproxy-cli-darwin-amd64"
    sha256 "d34e2fd989a8d90b9c72cb7f52f354e4aa5fba5044eea98ad4ff83ca3a3aef2a"
    version "2.1.2"
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
