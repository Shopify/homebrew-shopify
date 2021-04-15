class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/v1.2.1.tar.gz'

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any_skip_relocation, catalina: "cead7026c5bf46694ce67b5b664bd7a82570d76ff479de35dbb71d43a346b2d8"
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
