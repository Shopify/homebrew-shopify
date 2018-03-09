# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.2/toxiproxy-server-darwin-amd64"
  sha256 "320581f9a190592bdcefffb158c7ec971d9fbe193e7718be3d8c75aa2204ef7f"
  version "2.1.2"

  resource "cli" do
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.2/toxiproxy-cli-darwin-amd64"
    sha256 "7fe3be75cdabb925d4a7b3e430bda0a2833ac9ff0edf9ab9f1d3c985766b89ba"
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
