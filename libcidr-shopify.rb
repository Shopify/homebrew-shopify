class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://www.over-yonder.net/~fullermd/projects/libcidr'
  url 'http://bazaar.launchpad.net/~fullermd/libcidr/trunk/tarball/302'
  sha256 'cb3c51ffec7c6dd83dca1e7f3a92852e4febd230624e84457c269bec82432719'

  patch do
    url "https://gist.githubusercontent.com/fmejia97/ad72a1f2b5d4b77a2921f32d861850b8/raw/7888c4a21a1e2afcaf0cdff627d5643574d020a0/mac_os_libcidr_support.patch"
    sha256 "8578885fd5d8a5c5bf64b92283292c568ba8b38bf7d411a79b0533cfee8a546f"
  end

  def install
    Dir.chdir("./libcidr/trunk")
    system "./mkgmake.sh"
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
