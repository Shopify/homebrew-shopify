class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://github.com/Shopify/libcidr-shopify/'
  url 'http://bazaar.launchpad.net/~fullermd/libcidr/trunk/tarball/302'
  sha256 'cb3c51ffec7c6dd83dca1e7f3a92852e4febd230624e84457c269bec82432719'

  patch do
    url "https://gist.githubusercontent.com/fmejia97/ad72a1f2b5d4b77a2921f32d861850b8/raw/fb499d61e4645c04195a84deb293b2f7a2a4720e/mac_os_libcidr_support.patch"
    sha256 "b0400ea3bff166c189365c283874e0ff8888a6db89f7a0c541eff88dcd1f2b84"
  end

  def install
    Dir.chdir("./libcidr/trunk")
    system "./mkgmake.sh"
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
