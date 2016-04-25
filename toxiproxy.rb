# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v2.0.0/toxiproxy-server-darwin-amd64"
  sha256 "59b88ce5ad4a76e2cc1794fde6f500d2de8d33acf69383b24667eb81d73a41df"
  version "2.0.0"

  resource "cli" do
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.0.0/toxiproxy-cli-darwin-amd64"
    sha256 "5ac89fec1b4aab939e84563644f7155dd808a39b7745f3592b2cc2f6131929c4"
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
