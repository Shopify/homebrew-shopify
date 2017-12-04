class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-08e20d74b6992411aa203d296eb7ed7a1ac089ba.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1513005948&Signature=mpd7rbZa%2BxC0ceVrluc8H9uxwrfOuJdGYvn0eLzsI%2BuN41Pyfe3tkMAdepTrpOHu8MUm4ADovk8FJHxdtWbWdqkkTHZkw8NGF4VOfKIzqGXVPzE58DGMaxw2B2AFSj4rFCApltHxesW6Hd%2Fo%2BIf%2BryWQ9AjpKLXchy%2B%2BOB0FZxMuayLbA5aazLr%2B%2BGrA7XW7tFuwjzlgt%2F8aqy7qvtOdAcG5V8dvKw0DV9UcZb5GlveNQdqSaYEBst85eNRDTq%2B8uKvs1cd%2FVQTfyrymHa3bC%2BRFyvHEuQKk33dhknUxjnb%2Fue%2FSkuEDBmUd8JL3QzZ8SGuC2GEXxLgGQ2X%2BzOcqXw%3D%3D', using: GoogleStorageDownloadStrategy
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
      <false/>
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
