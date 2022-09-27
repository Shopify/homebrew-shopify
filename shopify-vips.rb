class ShopifyVips < Formula
  desc "Image processing library"
  conflicts_with "vips"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/archive/3b33d912c4e0be9e64be25a18252317dfb227dcf.tar.gz"
  sha256 "b43a426e88422e12448fc5046f4c5548019aa8c94df8febcc4f149aebb3cf69a"
  version "8.14.0"
  license "LGPL-2.1-or-later"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "glib-utils" => :build
  depends_on "gobject-introspection" => :build
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
    # force mozjpeg to be used: the regular libjpeg / libjpeg-turbo might be present on the system as well.
    ENV.prepend_path "PKG_CONFIG_PATH",Formula["mozjpeg"].opt_lib/"pkgconfig"
    system "meson", "setup", "build", "--prefix=#{prefix}", "-Dmagick-package=GraphicsMagick", "--buildtype=release"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/vips", "-l"
  end
end
