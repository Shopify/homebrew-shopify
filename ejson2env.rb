class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v1.0.1.tar.gz'
  sha256 'f8599c2dca6053914ea4731f4c8d539919917b6af2fc02951ca65400f567b296'

  # bottle do
  #   root_url "https://s3.amazonaws.com/burkelibbey"
  #   cellar :any_skip_relocation
  #   rebuild 1
  #   sha256 "a06274cc855a7204a600510c037646a05b05392bb609bba4a4d57e234b9b9022" => :high_sierra
  # end

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
