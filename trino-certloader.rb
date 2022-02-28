class TrinoCertloader < Formula
  desc 'Manage mTLS certificates for Conductor and Trino'
  homepage 'https://github.com/Shopify/certloader'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/certloader/certloader.target.zip'
  sha256 '63200d5dc9536652ffccde46d69ee389a6a490593118bb953bca20c0499a5b16'
  version "1.0.0"
  plist_options manual: "export GIN_MODE=release && #{HOMEBREW_PREFIX}/opt/trino-certloader/bin/trino-certloader"

  case
  when OS.mac? && Hardware::CPU.intel?
    @@binary_name = "certloader-darwin_amd64"
  when OS.mac? && Hardware::CPU.arm?
    @@binary_name = "certloader-darwin_arm64"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({@@binary_name => "trino-certloader"})
    mkdir_p var/"log/trino-certloader"
    mkdir_p var/"trino-certloader/certs"
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
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/trino-certloader</string>
        <string>--no-tracing</string>
        <string>-o=#{var}/trino-certloader/certs</string>
        <string>-vault.pki.path=certify/conductor/production</string>
        <string>-vault.auth.type=github</string>
        <string>-vault.auth.github.token.path=/opt/dev/var/private/git_credential_store</string>
        <string>-sync.interval=10s</string>
        <string>-cert.duration=1h</string>
        <string>-cert.renew-before=59m0s</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>#{var}/log/trino-certloader/trino-certloader_err.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/trino-certloader/trino-certloader.log</string>
    </dict>
    </plist>
    EOS
  end
  test do
    system "#{bin}/#{@@binary_name}", "--help"
  end
end
