class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/artifacts.data-148903.appspot.com/containers/repositories/library/apps/development/oauth-tunnel-client/oauth-tunnel-client-binaries-99e7cbbe391e17ef298ead69e035d167bb191077.tar.gz?GoogleAccessId=johnmartin-cloudsql-client@data-148903.iam.gserviceaccount.com&Expires=1510414285&Signature=F%2BoTSNtwgsuGOXIc5GZ%2BcXeU3M6j6HOfcEt5F4FX8fKEtzp84lX%2BSOkSNPFi5Z0pjhXUE4OXq9PCd71mskoq89VsYTsb1%2BM9Zx7ZU1hBJGvEUIc7QGhwo9NMwqn1PL7yct8H%2FUJ%2BfeQmoICGOzYsdNPSeCvujRDtkgwceoMVhLx11lPjaViCLSa%2FdyL76ih5C9k1jFvloGCStpsk7LBCf7PSJfC2mB6iheyjyy0sDBwIS%2BrTPXK6aF7GGdY97Xv%2BdLkS3tpWBUth13OCkXB5A%2FsjPGJOefUWZ4qooRDDK5p4QDYbiESARocXTGr%2B7luMADy8lPybrbij8U70lI4Oxw%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "323a8cee3daf1aab0a53ac3f7ff6d406f83227eee614a2f66b021d9ab9e44532"
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
