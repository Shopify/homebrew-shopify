class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v1.1.0.tar.gz'
  sha256 '546515d6220017812ec7369dfdccca6c2edc1d991ebaf25f78b5b09bf2497b6a'

  bottle do
    root_url "https://github.com/Shopify/ejson2env/releases/download/v1.1.0/"
    cellar :any_skip_relocation
    sha256 "23454ba67b4fc551722d22bb86685025765bba07f6bd57974d93de2aec4eb8f2" => :mojave
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
