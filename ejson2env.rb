class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v1.0.3.tar.gz'
  sha256 '805b84fae096b3b55de870ca9e83817c3bff0c1581cd09f70c99cc8321c8a025'

  bottle do
    cellar :any_skip_relocation
    sha256 "116419c566abe4d86f6317aac77940cde9071b1793c21dbcd2436e920569a37d" => :high_sierra
    root_url "https://github.com/Shopify/ejson2env/releases/download/v1.0.3/"
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
