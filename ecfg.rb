require 'fileutils'

class Ecfg < Formula
  desc 'ecfg is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ecfg'
  url 'https://github.com/Shopify/ecfg/archive/0.3.1.tar.gz'
  sha256 'a7c3659fc7b9fcba52f9843666f5b47f0231b104eb352a26ce0863dfcb931424'

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
