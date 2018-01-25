class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-3e10de5ca59b881acd691dc4022b052a77d44504.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1522076325&Signature=vSUnV1BKINiQvl38EULEw7eKVb0ju0yRd47BpSX%2FKUITS8jtvMBw35ug1%2FH9PBN%2BJRmNeR5PdZTUYWjHu6nxBSl1MqOUlfSKSSk%2Brv5kmaojX%2FibDA31da6MorBQ6i%2FgBE%2F4rVr93lxkSX%2Bz7siZWOEMvLTM3L3Zw%2BGecwOyGpscHhTm76YphBM8cI%2BB%2BzyI2i5djA6%2Bt0scQt%2Bmh%2B1RxLg0nIgxksP%2FzTGkkBwuvjb4nsj%2BGEC2FGCIkxUAYeeT5eJoOPfA2g02n1ZH7duS%2Fh6mnJcydRdzbIVxq8PWwox%2F7HcWDKXD082%2BLjK3RgKi7jC3qGUUGLE8%2BEltmd%2BtvQ%3D%3D', using: GoogleStorageDownloadStrategy 
  sha256 '02e45f457e1626a4dee7999f432afae6bf7cafa41dd414afa8b690a39f9ff94a'
  version "0.2"

  def install
    bin.install({'oauth-tunnel-client_darwin_amd64' => 'oauth-tunnel-client'})
    mkdir_p('/usr/local/var/log/oauth-tunnel-client/')
    chown(ENV['USER'], 'staff', '/usr/local/var/log/oauth-tunnel-client/')
    chmod(0750, '/usr/local/var/log/oauth-tunnel-client/', :verbose => true)
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
      <string>com.shopify.oauth-tunnel-client</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/bin/oauth-tunnel-client</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>/usr/local/var/log/oauth-tunnel-client/oauth-tunnel-client_err.log</string>
      <key>StandardOutPath</key>
      <string>/usr/local/var/log/oauth-tunnel-client/oauth-tunnel-client.log</string>
    </dict>
    </plist>
    EOS
  end
  test do
    system "#{bin}/oauth-tunnel-client_darwin_amd64", "version"
  end
end
