class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://github.com/Shopify/libcidr-shopify/'
  url 'https://github.com/Shopify/libcidr-shopify/archive/v1.0.0.tar.gz'
  sha256 '718fbb00ab1ae8f9e692ce6f917ee7b485420df1e05537f8ab871de6a667915d'

  def install
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
