class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-8f4230f154b660be5e1179467aec378d82427328.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1517692467&Signature=gia1mt6gLc3GmrECB0MBX862IGjg9H4ZcyjD0v6%2B0FfB%2Fd8vYuobDvQN4OyCTT20Y75KSWa2OSdDOTG7G8RoTBkLzMtW45nDE4ChTO9rfUXtLiojXbh3JR8ijFciObAYtcys%2FznT1T%2FQiwDnPYJKNWM5FjECd7VrbJVR48JdotsIeEbJeUTMunwRUr3a88GbzVDX6IF%2FB1FplIaUUZjbLLyQF9zGJOUXiqZmtqbl%2Bp5SOvHYe1is5p3eaFsV4vJW%2BOjiWiTtQ0nTRW2FfHiYLDVudqNW1X8eEKe%2BsU8WNjy5%2BuO4tO6xnI%2Fs7gVXFxvXLCIg5lUAcIiLeNH6qchpTg%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "29fbdd206e6cc818cf7643a27ed07be3a863ae755f19eeab975ec5991acace9e"
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
