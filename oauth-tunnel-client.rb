class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-99e7cbbe391e17ef298ead69e035d167bb191077.tar.gz?GoogleAccessId=johnmartin-cloudsql-client@data-148903.iam.gserviceaccount.com&Expires=1510506389&Signature=OuISGE7oMrOGDjAdt2Unvf4WQTM%2FyoIsQM41E%2BqsLjC%2FRfWdEiCV0r7tQXNMRdQXtWzBdkgpb%2FmHqjgduC%2B8unxSeDQjIOrdipOxLSGovDipBaVPSWp%2FifLM%2Fwd7a8Xk2Ya%2FLVJ%2Fl1WOenjKGjKuVfs2kG97C10x1YO1%2Bk6cIBybVVflGePBkURc7W3ugjcwMaAbkjHTCujcAnGaJAXh7kAHPCYy6%2BycrVa%2BkGTsxMlwugcdDSQnOY%2FjO%2Bg2VAZn92U1kFx3G13wIIP%2BWIrYNB8S2I1wGrPv06YCi4fkCdrm7UCGLr6iwroWiI8eotx6liNkuUIe3I1K1UOW%2BrjsUg%3D%3D', using: GoogleStorageDownloadStrategy
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
