class KeychainStatus < Formula
  desc "Display the status of the macOS keychain"
  homepage "https://github.com/Shopify/keychain-status"
  url "https://github.com/Shopify/keychain-status/archive/0.1.0.tar.gz"
  sha256 "667b42052f63e39461f7f7acec5fdc7f29dc496bba845a6f14358f27298738b6"
  head "https://github.com/Shopify/keychain-status.git"

  bottle do
    root_url "https://github.com/Shopify/keychain-status/releases/download/0.1.0/"
    cellar :any_skip_relocation
    sha256 "289bc354e9cfe72efaf040bc820f6293176b52ecbc2a337df0e55737316394f7" => :mojave
  end

  depends_on :xcode => :build

  def install
    system "swiftc", "-gnone", "-O", "keychain-status.swift"
    bin.install "keychain-status"
  end

  test do
    output = shell_output("#{bin}/keychain-status /Library/Keychains/System.keychain")
    actual_keys = output.each_line.map { |l| l.split(':', 2).first }

    assert_equal %w(unlocked readable writable), actual_keys
  end
end
