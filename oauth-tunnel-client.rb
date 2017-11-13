class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-1dc1346d9b1450d81fdf309610cef75067e67683.tar.gz?GoogleAccessId=data-gcs-readonly@data-148903.iam.gserviceaccount.com&Expires=1514662945&Signature=HLY4XQu0kcB2s3Y09sPgngCKTD8A3%2BrHA%2Fk%2BQveP9oinlzSx4wKbBf2a8sVKmoeLWeuTUCjOAYu93OkjTUhTvHDUMH3e6MMhVnIO%2FKlVOl0mjtLfYf2Wi6aFhA7VbroppN%2BwAIOmjNWiLRecpB5gmTXyTrzZgWIgbkOGNpeoNDqAqqsFMCabaGI03y1h%2FD%2Bzlf9orV9Vib3dPpwZ27OaauP2yMMEsKP8ir%2Bg2QrmijkMdO5O6jS883jnPJYGLrtTewdSf63mR9EKBKVgMFXbybUKMRrA2E%2BOVFvbkKv1Tm%2FHtjYEgvWg0tTJnwO3Q55w5Mq23Nf8gmRjsDk%2B6sfPwg%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "af7bb1c94db322f3a88dae6649a5004cd42a27ad80df0babdea55764cd18e44f"
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
