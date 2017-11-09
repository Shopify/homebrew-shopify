class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/oauth-tunnel-binaries/oauth-tunnel-client-binaries-b825f8d867e98d97005b274f5e5d7b0c62d40d52.tar.gz?GoogleAccessId=johnmartin-cloudsql-client@data-148903.iam.gserviceaccount.com&Expires=1514836801&Signature=U%2B6Nc8nWdbfFgXU2hmbz3iSwTIQM863wB2v6TdajBv3llYB09fHnldfyc1IrE9HhRxvM%2FdeT4iUKmCQdd%2BLMLdC163nPd6b2qeZHiLeyyxlFBwYESd7k5g3EjuAjc%2BHrtwTf%2FyG4WITWstQNQ%2BVKQUNjPxR%2B9Ss4t9Rl9UkcQT9HlWhgRDMNWXt54oLc%2BebQfLJ%2FFFpA%2FJurKnJt4rEzY7ONFK%2FOCASato777tR%2FAZyHLXpKYVSZbwazgSIeONcAgTaFk2wOXQxlPCFH%2FKiM79Mx698MgvKsoNtYRW4X9BH%2Fbg2kQZI4hoFJMiEmn3nvWY2HmiIWoDg6JJnBKGJDfQ%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "c0690931ad6a23647f8f2233d0ef6703719ebe0ffb4a6a13a1ed4716fdebabd7"
  version "0.1"

  def install
    bin.install({'oauth-tunnel-client_darwin_amd64' => 'oauth-tunnel-client'})
    Dir.mkdir(File.join(Dir.home, ".config", "oauth-client"), 0755)
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
