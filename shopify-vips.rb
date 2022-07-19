class ShopifyVips < Formula
  desc "Image processing library"
  conflicts_with "vips"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/archive/v8.13.0-rc2.tar.gz"
  sha256 "040e67f5a8f139602f459efde23f379087b0bb0f473cd287723ee73b3f6daf62"
  version "8.13"
  license "LGPL-2.1-or-later"
  revision 4

  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "glib-utils" => :build
  depends_on "cgif"
  depends_on "fftw"
  depends_on "freetype"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "harfbuzz"
  depends_on "hdf5"
  depends_on "graphicsmagick"
  depends_on "imath"
  depends_on "jpeg-xl"
  depends_on "libexif"
  depends_on "libheif"
  depends_on "libimagequant"
  depends_on "libpng"
  depends_on "librsvg"
  depends_on "libtiff"
  depends_on "libxml2"
  depends_on "mozjpeg"
  depends_on "openexr"
  depends_on "pango"
  depends_on "webp"
  uses_from_macos "expat"
  uses_from_macos "zlib"

  def install
    system "meson", "setup", "build", "--prefix=#{prefix}", "-Dmagick-package=GraphicsMagick", "--buildtype=release"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/vips", "-l"
  end
end
