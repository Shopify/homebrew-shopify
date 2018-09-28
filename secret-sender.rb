require 'fileutils'

class SecretSender < Formula
  desc 'SecretSender is a little utility to securely share secrets to other users.'
  homepage 'https://github.com/Shopify/secret-sender'
  url 'https://github.com/Shopify/secret-sender/archive/v1.0.0.tar.gz'
  sha256 'f395b5da63d6c031b756622b6ad8430e8ca54d60d8d7266d7132b1265c4e2d39'

  depends_on 'go' => :build

  bottle do
    root_url "https://github.com/Shopify/secret-sender/releases/download/v1.0.0"
    cellar :any_skip_relocation
    sha256 "d99c4766085be488aff1f00e4c07af0690e1817fde68a4f660e496f60dc1a12d" => :high_sierra
    sha256 "f302e954ef6fce38d9973a88017beebdd4ab81455e83930b27626ac734dad76e" => :mojave
  end

  def install
    FileUtils.mkdir_p('src/github.com/Shopify')
    FileUtils.ln_sf(Dir.pwd, 'src/github.com/Shopify/secret-sender')
    ENV['GOPATH'] = Dir.pwd
    system('go', 'build', '-o', 'secret-sender', 'github.com/Shopify/secret-sender')
    bin.install('secret-sender')
    man1.install('secret-sender.1')
  end
end
