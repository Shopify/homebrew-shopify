require 'fileutils'

class Ecfg < Formula
  desc 'ecfg is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ecfg'
  url 'https://github.com/Shopify/ecfg/archive/0.3.0.tar.gz'
  sha256 'f6b37702066e64d063491868e81e5d16b3e686920af6a79d1f1c8468f326bd21'

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
