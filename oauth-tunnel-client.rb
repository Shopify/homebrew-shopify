class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-0f60c23ea7ace2b6bb2b78f99d3c9b7ce2aed004.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1521301754&Signature=pMhFmL8HrPVcL34zVBloH5jKf%2Br3iME%2BbblU20eHbjaL1SMtkQk2FEAXV3eCXBkur1jtmUvdoop3hUuh7D1nn%2FdxtXvDcilTfpzzmFoJ9IUeHUwUuvFW7fFqL1Z43Cizi7RydCP1gYc0x7dLsFuHj1efPu%2BDDDWYJtNqPbUWoUEaK5lDvmsNbQ4cPukM5N3z7OLXFAO4n%2Fj98lagJZBx0%2BvI9Y06vU1XaLhDnl%2BLElr7VFr3ag900h20Dypg%2FwaaM3UITqnnGbp%2F1b%2BC%2FMKIH77DrvR2qAMWxtibKcCtfLd9smo9bSccKnyAY1PJd%2FAPrT4s3INWVTYfg06MGq%2BeSg%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "0c8ca864da2e76b0f91070f56854a40dd3a998c0af3a0b6ce06c345f0a80d8d3"
  version "0.1"

  def install
    bin.install({'oauth-tunnel-client_darwin_amd64' => 'oauth-tunnel-client'})
  end
  def plist
    home = Dir.home
    <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>com.shopify.oauth-tunnel-client</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/bin/oauth-tunnel-client</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardOutPath</key>
      <string>/var/log/oauth-tunnel-client/tunnel-client-out.log</string>
      <key>StandardErrorPath</key>
      <string>/var/log/oauth-tunnel-client/tunnel-client-err.log</string>
      <key>Debug</key>
      <true/>
    </dict>
    </plist>
    EOS
  end
  test do
    system "#{bin}/oauth-tunnel-client_darwin_amd64", "version"
  end
end
