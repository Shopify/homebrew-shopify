class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/v1.3.0.tar.gz'
  sha256 "4f09d99fc8546676fef945aeb9878bafae0f54fcfc4c188fe8bbd87e4146a60f"

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8b39327e7d88a5523ae64449b80c51a67f1e8419770e44831a30d1ad879c689"
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
