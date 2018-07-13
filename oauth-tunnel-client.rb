class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/oauth-tunnel/oauth-tunnel-client-99d32760b2433ca850d0b6f927ca77b1b1ecb06f.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1542043420&Signature=nizLTr6sCeVp5%2F92ftVYdRDphme%2BpnSfjzi1mcNRZaimQv%2FyZH%2Fp%2BvEe4cVOEeYspz%2Fko%2FxKqgjyp%2FDNCZY98BDGZMWdJPOBv8d1cbgufZSgzHf3e%2FmBDu3zkMewGPWgtX1cx9VNQ5vE6R7qcR%2BdVRDYQGFnEiS0HldY95bYPclThuGFMxitHfzm9oqLabOXJWN5k4xjMnVaImRuR2ROIxjDwSIOIE3TkwLoN2k2rxbAoc7nPcIZR6GO4ccggVmXk6EEMmxN4NG7xZP3w04XID%2F12IwJdO1SDfAgwXJZ8JVmiQWG2RaKggFVEvmOvKaI5aJDnIshxDShmv%2BPY8vkKQ%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 '9964fa651f1e3fc57759868fc8779bb7b238de8881608d35690c677309e09b27'
  version "0.3.1"

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
