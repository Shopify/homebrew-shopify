require 'fileutils'

class Ecfg < Formula
  desc 'ecfg is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ecfg'
  url 'https://github.com/Shopify/ecfg/archive/0.3.0.tar.gz'
  sha256 '507f6831d726590da71548d49fd1085099506756a8da6a0ee30a70b0b52f5b74'

  depends_on 'go' => :build

  def install
    mkdir_p(buildpath/'src/github.com/Shopify')
    ln_sf('../../..', buildpath/'src/github.com/Shopify/ecfg')
    system('env', "GOPATH=#{buildpath}", 'make', 'build/bin/darwin-amd64')

    bin.install('build/bin/darwin-amd64' => 'ecfg')
    man1.install(Dir[buildpath/'man/man1/*'])
    man5.install(Dir[buildpath/'man/man5/*'])
  end
end
