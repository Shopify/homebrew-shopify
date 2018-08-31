class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v1.0.1.tar.gz'
  sha256 'f8599c2dca6053914ea4731f4c8d539919917b6af2fc02951ca65400f567b296'

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    cellar :any_skip_relocation
    sha256 "02b6d26a60455a520286400b7db6613ee300bdcebbc2b44bc9740c283d72aa94" => :high_sierra
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
    system('go', 'build', '-o', 'ejson2env', 'github.com/Shopify/ejson2env/cmd/ejson2env')
    system('make', 'man')

    bin.install 'ejson2env'
    man1.install Dir[buildpath/'build/man/*']
  end
end
