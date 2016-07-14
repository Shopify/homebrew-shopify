require 'fileutils'

class Ecfg < Formula
  desc 'ecfg is a small library to manage encrypted secrets using asymmetric encryption.'
  homepage 'https://github.com/Shopify/ecfg'
  url 'https://github.com/Shopify/ecfg/archive/0.2.0.tar.gz'
  sha256 '242ca6f9dc41019f0971ee8cfd93f076d1ec416e13b1e6dbaa30a22dec8c0a7b'


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
