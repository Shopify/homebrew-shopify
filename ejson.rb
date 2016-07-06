class Ejson < Formula
  desc 'EJSON is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ejson'
  url 'https://github.com/Shopify/ejson/archive/1.0.1.tar.gz'
  sha256 'a0d351b53e8bf3368276fced733f94054aca88b4ef5ef0a3a5000dfb23f5435f'

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
