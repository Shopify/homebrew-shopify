# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  homepage "https://github.com/Shopify/toxiproxy"
  url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.4/toxiproxy-server-darwin-amd64"
  sha256 "a27061bab304465dc0683602ecce40743214f441b186ff72766e4683246c0f5f"
  version "2.1.4"

  resource "cli" do
    url "https://github.com/Shopify/toxiproxy/releases/download/v2.1.4/toxiproxy-cli-darwin-amd64"
    sha256 "af7263023bbba1e8b347b5ec4bf18557b069abbe015bffbdb5109607b6808bdb"
    version "2.1.4"
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
