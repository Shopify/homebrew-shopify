class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-3d598b521f6a38a0e520abcb88861a2f19612138.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1538846760&Signature=ZFurNLDuykVYAmETTYbe139u9tAGnNGtTrT7EE4S3F90AA15bQtAzUHh6XW9AbEuVyGlvIYP2LDHi7FejgVW7c5e%2BeaoqLeTlSFy8bIz9i8tZUyVMu3frHMt%2BvGVLZfVVj%2BgcBvuB79HGEJvzTjc1UKfDpzXnRWR8TytajSy9FsSrtEuhIc7Kpj8rvaX41MfX3996%2Bnj%2BMVfNVwM64CBTDgttgl2FtxxCTFK6wNa8U4RR9UCyBbGQ6hFVdSuXYxwViPanjqawVyJPzGzQKkPAaeVswfQHscWb0s%2FfGjIt0KBOAtU%2Bad0BC7O17Anu7Qtg9ETmkzgvL3KQRoavMLf1A%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 '5792276bab2151408320f10d5b85480e52a3d95eaff260eb2577d8288bdade44'
  version "0.2.1"

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
