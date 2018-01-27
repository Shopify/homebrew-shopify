class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://www.over-yonder.net/~fullermd/projects/libcidr'
  url 'https://www.over-yonder.net/~fullermd/projects/libcidr/libcidr-1.2.3.tar.xz'
  sha256 'afbe266a9839775a21091b0e44daaf890a46ea4c2d3f5126b3048d82b9bfbbc4'

  patch do
    url "https://raw.githubusercontent.com/Shopify/homebrew-shopify/3b468e634f3084d1ad2eed26d8b24fd2c61bfbfe/patch/mac_os_libcidr_support.patch"
    sha256 "fac7310e3dda9ac2a7fc4abd435f1ddcd2300191523b7a83bf2b9eaa683a1271"
  end

  def install
    system "./mkgmake.sh"
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
