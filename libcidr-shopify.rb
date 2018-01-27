class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://www.over-yonder.net/~fullermd/projects/libcidr'
  url 'https://www.over-yonder.net/~fullermd/projects/libcidr/libcidr-1.2.3.tar.xz'
  sha256 'afbe266a9839775a21091b0e44daaf890a46ea4c2d3f5126b3048d82b9bfbbc4'

  patch do
    url "https://gist.githubusercontent.com/fmejia97/ad72a1f2b5d4b77a2921f32d861850b8/raw/cd2d5d2c3737f585fc71226786ea82279bf36645/mac_os_libcidr_support.patch"
    sha256 "92b72bdc3fab7c95f3689d451d67848b1c4d1d9da58561e3db6e3d5ca57cb399"
  end

  def install
    system "./mkgmake.sh"
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
