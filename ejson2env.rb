class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  url 'https://github.com/Shopify/ejson2env/archive/v2.0.2.tar.gz'
  sha256 '6fed90dfe6ccb8537ac7e226f19db4fe293fce2958f37530537748d2cb81fde2'

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any_skip_relocation, big_sur: "e1a65c8f25324ed4294a7fbc77b24f979906d1d03d5e65bee4a3f44c675681c2"
    sha256 cellar: :any_skip_relocation, monterey: "8a241cbf57802bb0516528496b7894e0ea2354cdf5a4dd4b9d28f2e2e9a831a0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2bd3d5c09d67d67a21f4d932668a909ce5d0fabbf4b473afe5f611f660e540b"
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
