class Ejson < Formula
  desc "Small library to manage encrypted secrets using asymmetric encryption"
  homepage "https://github.com/Shopify/ejson"
  version "1.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_darwin_arm64.tar.gz"
      sha256 "3fd3de884d448b4c42a368f0bef0fa1a639be3e971c0a6154dd2fdaac3d65e0a"
    end
    on_intel do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_darwin_amd64.tar.gz"
      sha256 "5ad5921b4045cd89a1f5f5f93c6d0016f0cb486154dd172d84ec9231370615cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_linux_arm64.tar.gz"
      sha256 "b991dbfaeb7e5db63ee9ad05a998e4c501e0f154bae63a45d5df141ba1847b44"
    end
    on_intel do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_linux_amd64.tar.gz"
      sha256 "2bb8300cf4f3cd41f56493e4277d2321eaab4f08208a5046e1b62a05337c3aee"
    end
  end

  def install
    bin.install "ejson"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ejson --version")
  end
end
