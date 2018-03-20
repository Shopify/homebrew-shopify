class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-b1dfd5b0f7d9c5abd0601192e1132fc03b1676f1.tar.gz?GoogleAccessId=pipa-production@shopify-docker-images.iam.gserviceaccount.com&Expires=1521647008&Signature=mPFZIYx069THKCQzm7VULjH6WRS0cbsn2x%2Fbt34zEKCseze3xlgiYgK1gr5LOjw4kXO3Cds7eEISoo5iQP8mqJfqZo3d2d3Od2%2Fw8coTn9ubb%2BXCEPYzBKhVxsz1XwVD1XZz4VjxA1gqWnz4fYHPxjseAIvTJkySmirday9EVcY2iUM5AY3v4MFxiJiYas7ngSwkHA5SeToo%2Fq1d%2B%2BO3IqkEmgLrT2J5TU%2FcPqnzPybiQg4rvhCZ7dmv3Fpdooyl4aAQxvo6zDjrwNSFjr2ARnoFiSzTmxiaPfpQtbnIfmSCVBcvRie%2Bn7NkvzbJDqxQtXw7NlcOAWyoPwfhMg73oA%3D%3D', using: GoogleStorageDownloadStrategy 
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
