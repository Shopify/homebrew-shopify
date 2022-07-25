class ShopifyVips < Formula
  desc "Image processing library"
  conflicts_with "vips"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/archive/v8.13.0.tar.gz"
  sha256 "8f7cb1806bcde834ee056853254d3643407ade280e24b6d1ddb8f155c9eb25f7"
  version "8.13"
  license "LGPL-2.1-or-later"
  revision 5

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
