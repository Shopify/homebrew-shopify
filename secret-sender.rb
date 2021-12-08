require 'fileutils'

class SecretSender < Formula
  desc 'SecretSender is a little utility to securely share secrets to other users.'
  homepage 'https://github.com/Shopify/secret-sender'
  url 'https://github.com/Shopify/secret-sender/archive/v2.0.1.tar.gz'
  sha256 '404f490140a843e3d196598bd0892d3991f27a2d3e6e70899553a5f702235ff6'

  depends_on 'go' => :build

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b1342e171060b9bd5cb8b32f423ae631c23dde0045140791aa5d0d46fe87a580"
    sha256 cellar: :any_skip_relocation, monterey: "463966f8acaaeb21f9d73e04cb3f8c2ee6f6c7ddc8e6fb047062f069e0eead5a"
  end

  def install
    system('go', 'build')
    bin.install('secret-sender')
    man1.install('secret-sender.1')
  end
end
