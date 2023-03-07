class OauthTunnelClient < Formula
  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/oauth-tunnel/oauth-tunnel-client-c3219ecfeef1965c6524040f99aea53bdbfde9af.tar.gz'
  sha256 'c1b3d5b5ee6b92f4f44795b23e76742398759f21b235a386f7cf9d507cbc099a'
  version "1.0.0"

  case
  when OS.mac? && Hardware::CPU.intel?
    @@binary_name = "oauth-tunnel-client_darwin_amd64"
  when OS.mac? && Hardware::CPU.arm?
    @@binary_name = "oauth-tunnel-client_darwin_arm64"
  when OS.linux? && Hardware::CPU.intel?
    @@binary_name = "oauth-tunnel-client_linux_386"
  when OS.linux? && Hardware::CPU.arm?
    @@binary_name = "oauth-tunnel-client_linux_arm64"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({@@binary_name => 'oauth-tunnel-client'})
    mkdir_p var/"log/oauth-tunnel-client"
  end

  service do
    run [bin/"oauth-tunnel-client"]
    environment_variables GIN_MODE: "release"
    log_path var/"log/oauth-tunnel-client/oauth-tunnel-client.log"
    error_log_path var/"log/oauth-tunnel-client/oauth-tunnel-client_err.log"
  end

  test do
    system "#{bin}/#{@@binary_name}", "version"
  end
end
