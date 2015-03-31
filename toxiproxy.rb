# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v1.0.1/toxiproxy-darwin-amd64"
  sha1 "05de584c56572330e6dd5c1cb2d38a5f388fe76e"
  version "1.0.1"

  depends_on :arch => :x86_64

  def install
    bin.install "toxiproxy-darwin-amd64" => "toxiproxy"
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
          <string>#{opt_bin}/toxiproxy</string>
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
