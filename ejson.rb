class Ejson < Formula
  desc "Small library to manage encrypted secrets using asymmetric encryption"
  homepage "https://github.com/Shopify/ejson"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_darwin_arm64.tar.gz"
      sha256 "cd43c9dbc729e8e46f4357c52bb1201976aade036f37bcc2274221db12401467"
    end
    on_intel do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_darwin_amd64.tar.gz"
      sha256 "49b9cf0c69610a27fcf1663561af280d93976c64e40cf44eeac0e365353b4f14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_linux_arm64.tar.gz"
      sha256 "5f83e72c96b6cd22a3f2f67b3ff8e0a2b26872cc3eac2db7e4731562d4d0b06b"
    end
    on_intel do
      url "https://github.com/Shopify/ejson/releases/download/v#{version}/ejson_#{version}_linux_amd64.tar.gz"
      sha256 "354d17e0c05bcb26d64a68205a615750f3504f3ed035f0d7b962f2d0eebcf023"
    end
  end

  def install
    bin.install "ejson"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ejson --version")
  end
end
