class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v1.0.4.tar.gz'
  sha256 '2372eff8dc66152e7a3aeec5fdd9103af893e66aecc69c07608b3649125bda78'

  bottle do
    root_url "https://github.com/Shopify/ejson2env/releases/download/v1.0.4/"
    cellar :any_skip_relocation
    sha256 "e8fedfe95dc94e481a8b5e3125e6b86bd9a0e4d2f9578e7a609bce7cd1cf363f" => :high_sierra
    sha256 "8808f5080cb858dadaad98980e62520f1421c78f46f5f5413e68201568ca9095" => :mojave
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
