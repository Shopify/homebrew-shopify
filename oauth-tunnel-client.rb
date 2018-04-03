class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-b3dbaecc99f72f0f5373f71402e890ac6ab22f75.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1540049120&Signature=JEE3QRS2iaVOE5%2BjXVPk3jqItYwPW%2B0uflh5Hrak5l9LR7iArPaGqFmBXEXIcf5onEAL6E4%2FqM8o0S3%2BdHtZgsh%2BNwRebU8REHzSW8SSJ%2B3aBoc5twGoLQpzhVZXHW1xTBDBkl5bfNMFjo1Kc2D%2FdX48ceRSZtoLvHXT3NRwAMydlpMAvyI%2FZ2N2Jwj5jR%2BGO4Ae%2FlSkekAJDIDuBs2nmcf2TQjvOhIhn9BjsZqgWkYF70z8iH75zL%2B3lLvlZfCSRlokrinMqsGDwptwbZ4J3hYhlCm6ZxHQ4vY%2B3W31i6vS4dFbVBhX4HRus6jv7BhJivHpYkVOhECi2Vvj34bUJQ%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 '1412e75a03ed41c2285fc9a9b329183023cd702fbbea941e524893ce1fe0aeeb'
  version "0.3.0"

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
