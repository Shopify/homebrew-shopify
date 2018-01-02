class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-02ec2ac7fb1e6bb5d587d6418ae714731cc0355e.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1518965251&Signature=zc%2FtNlj9KKPohMgguxrO%2FcXBEcDaEz%2FTLv5U72lhkJoyc6X%2BJ7Ct2S%2B8TIg7EPofkNQNVnqIVAXZpd5wXny%2Be6LgVNsDYe6prcl1ROvg9Y%2FfXS%2BgX21x9i8HnCpcaWuOAdn5fmcQUh30u6uosn7fUwpAzsQFKgh7QMbHJxjCFGjVOnI%2F4szHmwr1rbSd1G2YW8sy0D3b5qvXabPQ%2BflYnAhMzaDG5av2LD8Dk2Pd4ZuRFrBrb32IBWgkS9USjgQVAljIgE8CZoQa%2BWshISvqHuDMWQae85Ym0kBvLSb%2BrpWlRtyy%2B7l2KHv9fCeiRxDxNNEZ1wnvl0l2NbDrKYkRKA%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "91579ff7640f42c3682025e2eef2ded434f7088fcd7e64bd1da82dba54231f89"
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
