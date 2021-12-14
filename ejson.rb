class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/v1.3.1.tar.gz'
  sha256 '5c2bd9f1bec018f64be97d68a0ef1dc48763613e0c85d731ba96705b0720b779'

  bottle do
    root_url 'https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding'
    sha256 cellar: :any_skip_relocation, arm64_monterey: '6f308923a7d1e00640692bcf19b30d491cb6fcb5836a091931d65a57fa0e8b12'
    sha256 cellar: :any_skip_relocation, monterey: '4ffdee0338de07d3983b2b2bba0e0c20cad9cdcb9fd52369228a144956374a14'
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
