class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/v1.2.0.tar.gz'

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    cellar :any_skip_relocation
    sha256 "b7add2e890b2dac8580cdd43de77fa7f979758f66d7ecb470ab1e9e73065c04c" => :high_sierra
    sha256 "9f94ed3c05634be285c85e4488d3bdaf5a5e40306d99a3af5c968a38be011bbf" => :mojave
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "f3d395b49bf9e877de1ef0a0e4b3f9ca7d78ef800fbd51bb723e0c2a52162288" => :catalina
  end

  depends_on 'go' => :build

  def install
    ENV['GEM_HOME'] = buildpath/'.gem'
    ENV['PATH'] = "#{ENV['GEM_HOME']}/bin:#{ENV['PATH']}"
    system('gem', 'install', 'bundler')
    system('bundle', 'install')
    ENV['GOPATH'] = buildpath/'.gopath'
    system('mkdir', '-p', buildpath/'.gopath/src/github.com/Shopify')
    system('ln', '-sf', buildpath, buildpath/'.gopath/src/github.com/Shopify/ejson')
    system('go', 'build', '-o', 'ejson', 'github.com/Shopify/ejson/cmd/ejson')
    system('make', 'man')

    bin.install 'ejson'
    man1.install Dir[buildpath/'build/man/man1/*']
    man5.install Dir[buildpath/'build/man/man5/*']
  end
end
