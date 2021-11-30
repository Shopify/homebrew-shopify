class OauthTunnelClient < Formula
  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/oauth-tunnel/oauth-tunnel-client-c3219ecfeef1965c6524040f99aea53bdbfde9af.tar.gz'
  sha256 'c1b3d5b5ee6b92f4f44795b23e76742398759f21b235a386f7cf9d507cbc099a'
  version "1.0.0"

  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  binary_name = "oauth-tunnel-client_darwin_#{arch}" 

  def install
    bin.install({binary_name => 'oauth-tunnel-client'})
    mkdir_p var/"log/oauth-tunnel-client"
  end
  def plist
    home = Dir.home
    <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>EnvironmentVariables</key>
      <dict>
       <key>GIN_MODE</key>
       <string>release</string>
      </dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>/opt/homebrew/bin/oauth-tunnel-client</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>/opt/homebrew/var/log/oauth-tunnel-client/oauth-tunnel-client_err.log</string>
      <key>StandardOutPath</key>
      <string>/opt/homebrew/var/log/oauth-tunnel-client/oauth-tunnel-client.log</string>
    </dict>
    </plist>
    EOS
  end
  test do
    system "#{bin}/#{binary_name}", "version"
  end
end
