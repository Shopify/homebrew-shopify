class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-08e20d74b6992411aa203d296eb7ed7a1ac089ba.tar.gz?GoogleAccessId=data-gcs-readonly@data-148903.iam.gserviceaccount.com&Expires=1515013862&Signature=w%2Fk%2BSrQgwvuSV98GLCl%2B31j3iaocbpMQ%2FYZV1%2FLcYsiQRQR2a9j9biZdjY1c777KhaOGo0MnCsAsSJMbYQdYWA3KKHFfj4Bv%2FnuWzL0%2FucCNF%2Fd6US1EMIPqjSBixfIxrHXFY9p6X%2F1mMD3vr6Ua5ZChe2p%2BG516b1MCQu4cK67tLRTiW%2FEycyYZ7tcmwU4%2BFNwqBEAyc4rZhwJMwKCDfPxdFaRXLMnRN6J95qpZYQa2dBsHG7v6gESpkQIvHyga%2FXep%2FSwt4KGOpZq2K3Bp8tz1Q%2FeiK2KAsGc6oYnjShDDlXFHWNeAg%2FI76Dhee6c0tNlbCAbr5oKXqjtUy6OIKg%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "8a8cfc2305093f5c255899380327d0441f72191231bb38f7dfb6c8101baf1195"
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
      <string>#{home}/.oauth-tunnel-client/tunnel-client-out.log</string>
      <key>StandardErrorPath</key>
      <string>#{home}/.oauth-tunnel-client/tunnel-client-err.log</string>
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
