# This file was copied from homebrew/homebrew:graphicsmagick.rb, changes include:
# * url and sha256 changed to newer tarball
# * conflict with graphicsmagick added
# * bottle stanza updated
class ShopifyGraphicsmagick < Formula
  desc "Image processing tools collection"
  homepage "http://www.graphicsmagick.org/"
  url "http://apt.shopify.com/dist/graphicsmagick/GraphicsMagick-1.4.020150705.tar.bz2"
  sha256 "334fa009c7a1b5b91849b971ec85dffff19fb23737568cfdb49aee853731e7a5"
  revision 1

  bottle do
    root_url "http://burkelibbey.s3.amazonaws.com"
    sha256 "754fb38cc5eb8eff944377d78e000177438bc76db9937675c741364e39f77bd3" => :el_capitan
  end

  conflicts_with "graphicsmagick", :because => "shopify-graphicsmagick is newer"

  head "http://hg.code.sf.net/p/graphicsmagick/code", :using => :hg

  option "with-quantum-depth-8", "Compile with a quantum depth of 8 bit"
  option "with-quantum-depth-16", "Compile with a quantum depth of 16 bit (default)"
  option "with-quantum-depth-32", "Compile with a quantum depth of 32 bit"
  option "without-magick-plus-plus", "disable build/install of Magick++"
  option "without-svg", "Compile without svg support"
  option "with-perl", "Build PerlMagick; provides the Graphics::Magick module"

  depends_on "libtool" => :run

  depends_on "pkg-config" => :build

  depends_on "jpeg" => :recommended
  depends_on "libpng" => :recommended
  depends_on "libtiff" => :recommended
  depends_on "freetype" => :recommended

  depends_on :x11 => :optional
  depends_on "little-cms2" => :optional
  depends_on "jasper" => :optional
  depends_on "libwmf" => :optional
  depends_on "ghostscript" => :optional
  depends_on "webp" => :optional

  fails_with :llvm do
    build 2335
  end

  skip_clean :la

  def ghostscript_fonts?
    File.directory? "#{HOMEBREW_PREFIX}/share/ghostscript/fonts"
  end

  def install
    quantum_depth = [8, 16, 32].select { |n| build.with? "quantum-depth-#{n}" }
    if quantum_depth.length > 1
      odie "graphicsmagick: --with-quantum-depth-N options are mutually exclusive"
    end
    quantum_depth = quantum_depth.first || 16 # user choice or default

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --enable-shared
      --disable-static
      --with-modules
      --disable-openmp
      --with-quantum-depth=#{quantum_depth}
    ]

    args << "--without-gslib" if build.without? "ghostscript"
    args << "--with-gs-font-dir=#{HOMEBREW_PREFIX}/share/ghostscript/fonts" if build.without? "ghostscript"
    args << "--without-magick-plus-plus" if build.without? "magick-plus-plus"
    args << "--with-perl" if build.with? "perl"
    args << "--with-webp=yes" if build.with? "webp"
    args << "--without-x" if build.without? "x11"
    args << "--without-ttf" if build.without? "freetype"
    args << "--without-xml" if build.without? "svg"
    args << "--without-lcms2" if build.without? "little-cms2"

    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_VERSION}", "${PACKAGE_NAME}"
    system "./configure", *args
    system "make", "install"
    if build.with? "perl"
      cd "PerlMagick" do
        # Install the module under the GraphicsMagick prefix
        system "perl", "Makefile.PL", "INSTALL_BASE=#{prefix}"
        system "make"
        system "make", "install"
      end
    end
  end

  def caveats
    if build.with? "perl"
      <<-EOS.undent
        The Graphics::Magick perl module has been installed under:

          #{lib}

      EOS
    end
  end

  test do
    system "#{bin}/gm", "identify", test_fixtures("test.png")
  end
end
