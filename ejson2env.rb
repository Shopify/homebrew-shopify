class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v2.0.0.tar.gz'
  sha256 '77e9ac0c546a41741448375955557f24d96b09ba8a715216b1fee008ae165f5b'

  bottle do
    cellar :any_skip_relocation
    root_url "https://github.com/Shopify/ejson2env/releases/download/v2.0.0/ejson2env-2.0.0.mojave.bottle.tar.gz"
    sha256 "6e24d9eab03fde39db3a4539e19a1634a93e0d6c03fcc0a427b419483e3cc79f" => :mojave
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "b404911246f78cc2ae55a34953d939fdc89b8988d2779486d2ea22a9aede8bdf" => :catalina
  end

  depends_on 'go' => :build

  def install
    ENV['GEM_HOME'] = buildpath/'.gem'
    ENV['PATH'] = "#{ENV['GEM_HOME']}/bin:#{ENV['PATH']}"
    system('gem', 'install', 'bundler')
    system('bundle', 'install')
    system('mkdir', '-p', buildpath/'.gopath/src/github.com/Shopify')
    ENV['GOPATH'] = buildpath/'.gopath'
    system('ln', '-sf', buildpath, buildpath/'.gopath/src/github.com/Shopify/ejson2env')
    system(
      'go',
      'build',
      '-ldflags',
      '-s -w -X main.version=2.0.0',
      '-o',
      'ejson2env',
      'github.com/Shopify/ejson2env/cmd/ejson2env'
    )
    system('make', 'man')

    bin.install 'ejson2env'
    man1.install Dir[buildpath/'build/man/*']
  end
end
