class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://github.com/Shopify/libcidr-shopify/'
  url 'https://github.com/Shopify/libcidr-shopify/archive/v1.1.0.tar.gz'
  sha256 'ba1fc083dbf39a902bf17add9628b3e5b988385d7a1e8006293372e1094f11e6'

  def install
    system "make"
    system "make", "install"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
