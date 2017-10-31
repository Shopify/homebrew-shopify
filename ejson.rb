class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/1.1.0.tar.gz'
  sha256 'edf474588357074ed3f0e2b7f1ecacd006bd6edde32e2fb7ffc3d7fe4040e029'

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    cellar :any_skip_relocation
    sha256 "17a5f58a5555dc90cb29b340e15c7fffd8290930a0200f94c874dd5be7390eaa" => :high_sierra
  end

  depends_on 'go' => :build

  def install
    ENV['GEM_HOME'] = buildpath/'.gem'
    ENV['PATH'] = "#{ENV['GEM_HOME']}/bin:#{ENV['PATH']}"
    system('gem', 'install', 'bundler')
    system('bundle', 'install')
    vendor = buildpath/'Godeps/_workspace'
    ENV['GOPATH'] = vendor
    system('mkdir', '-p', buildpath/'Godeps/_workspace/src/github.com/Shopify')
    system('ln', '-sf', buildpath, buildpath/'Godeps/_workspace/src/github.com/Shopify/ejson')
    system('go', 'build', '-o', 'ejson', 'github.com/Shopify/ejson/cmd/ejson')
    system('make', 'man')

    bin.install 'ejson'
    man1.install Dir[buildpath/'build/man/man1/*']
    man5.install Dir[buildpath/'build/man/man5/*']
  end
end
