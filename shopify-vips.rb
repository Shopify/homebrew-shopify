class ShopifyVips < Formula
  desc "Image processing library"
  conflicts_with "vips"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.15.1/vips-8.15.1.tar.xz"
  sha256 "06811f5aed3e7bc03e63d05537ff4b501de5283108c8ee79396c60601a00830c"
  version "8.15.1"
  license "LGPL-2.1-or-later"
  revision 0

  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gobject-introspection" => :build
  # weird issue with libxcb:
  # cairo needs it. libxcb specifies that it needs libpthread-stubs in the pkg-config (.pc) file,
  # but the libxcb Homebrew formula doesn't depend on libpthread-stubs anymore.
  # Fix (for now) by depend on libpthread-stubs for build. This should potentially be reported upstream.
  depends_on "libpthread-stubs" => :build
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
    system "meson", "setup", "build", "--prefix=#{prefix}", "--buildtype=release",
    "-Dintrospection=disabled", \
    "-Ddeprecated=false", \
    "-Dexamples=false", \
    "-Dcplusplus=false", \
    "-Dmodules=disabled", \
    "-Dmagick-package=GraphicsMagick", \
    "-Danalyze=false", \
    "-Dcfitsio=disabled", \
    "-Dfftw=disabled", \
    "-Dfontconfig=disabled", \
    "-Dopenjpeg=disabled", \
    "-Dmatio=disabled", \
    "-Dnifti=disabled", \
    "-Dopenexr=disabled", \
    "-Dopenslide=disabled", \
    "-Dorc=disabled", \
    "-Dpangocairo=disabled", \
    "-Dpdfium=disabled", \
    "-Dpoppler=disabled", \
    "-Dppm=false", \
    "-Dquantizr=disabled", \
    "-Dradiance=false"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/vips", "-l"
  end
end
