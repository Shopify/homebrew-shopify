class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v2.0.1.tar.gz'
  sha256 'b6fdae0b9e8f5f74124ecf3c25dee8c36dfaac0ac6b85d82250761e5ebd58de2'

  bottle do
    cellar :any_skip_relocation
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "e55edfb055c4c6b7258f18f9d1677e9d545902009b0d9f8b43f60bbef02def73" => :catalina
    sha256 "c65f899fd64aaa487e945da0e80e8bc17611ed8c1bd4d56a7067fc3824de4912" => :big_sur
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
      '-s -w -X main.version=2.0.1',
      '-o',
      'ejson2env',
      'github.com/Shopify/ejson2env/cmd/ejson2env'
    )
    system('make', 'man')

    bin.install 'ejson2env'
    man1.install Dir[buildpath/'build/man/*']
  end
end
