class LibcidrShopify < Formula
  desc 'Libcidr is a library that provides utility functions to handle IP addresses and net blocks.'
  homepage 'https://www.over-yonder.net/~fullermd/projects/libcidr'
  url 'http://bazaar.launchpad.net/~fullermd/libcidr/trunk/tarball/302'
  sha256 '44d99c491a90d01baf0e074f6b5bac48e7eab93e97835819f631ef2a8bd12935'

  # This patch can be viewed and edited via https://gist.github.com/fmejia97/ad72a1f2b5d4b77a2921f32d861850b8
  # This path can also be accessed via homebrew-shopify/patch/mac_os_libcidr_support.patch
  patch do
    url "https://gist.githubusercontent.com/fmejia97/ad72a1f2b5d4b77a2921f32d861850b8/raw/151aabb91fe183ca3d18521c29f90007aa690592/mac_os_libcidr_support.patch"
    sha256 "76459e78199b2ea94f0522af24262ea259fb74e5ba38acd9619a58390eafd599"
  end

  def install
    Dir.chdir("./libcidr/trunk")
    system "./mkgmake.sh"
    system "make"
    lib.install "./src/libcidr.dylib"
    lib.install "./src/libcidr.dylib.0"
  end
end
