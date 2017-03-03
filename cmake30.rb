class NoExpatFramework < Requirement
  def expat_framework
    "/Library/Frameworks/expat.framework"
  end

  satisfy :build_env => false do
    !File.exist? expat_framework
  end

  def message; <<-EOS.undent
    Detected #{expat_framework}

    This will be picked up by CMake's build system and likely cause the
    build to fail, trying to link to a 32-bit version of expat.

    You may need to move this file out of the way to compile CMake.
    EOS
  end
end

class Cmake30 < Formula
  desc "Cross-platform make"
  homepage "http://www.cmake.org/"
  url "http://www.cmake.org/files/v3.0/cmake-3.0.2.tar.gz"
  sha256 "6b4ea61eadbbd9bec0ccb383c29d1f4496eacc121ef7acf37c7a24777805693e"

  bottle do
    cellar :any
    sha256 "71b46be0b22a43368e8beddeb50c758d281684597bfb578c0e883151c968869f" => :yosemite
    sha256 "5cbd2d245b6bb71480ac15d901d2caa8558f4429d2535fbef662e53431679cb2" => :mavericks
    sha256 "21a42c38e5b78dac6598d3eedf7b26e1c856410614384ca747e277428254a4a8" => :mountain_lion
  end

  option "without-docs", "Don't build man pages"
  depends_on :python => :build if MacOS.version <= :snow_leopard && build.with?("docs")

  depends_on "qt" => :optional

  conflicts_with "cmake", :because => "both install a cmake binary"
  conflicts_with "cmake28", :because => "both install a cmake binary"
  conflicts_with "cmake31", :because => "both install a cmake binary"

  resource "sphinx" do
    url "https://pypi.python.org/packages/source/S/Sphinx/Sphinx-1.2.3.tar.gz"
    sha256 "94933b64e2fe0807da0612c574a021c0dac28c7bd3c4a23723ae5a39ea8f3d04"
  end

  resource "docutils" do
    url "https://pypi.python.org/packages/source/d/docutils/docutils-0.12.tar.gz"
    sha256 "c7db717810ab6965f66c8cf0398a98c9d8df982da39b4cd7f162911eb89596fa"
  end

  resource "pygments" do
    url "https://pypi.python.org/packages/source/P/Pygments/Pygments-1.6.tar.gz"
    sha256 "799ed4caf77516e54440806d8d9cd82a7607dfdf4e4fb643815171a4b5c921c0"
  end

  resource "jinja2" do
    url "https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.7.3.tar.gz"
    sha256 "2e24ac5d004db5714976a04ac0e80c6df6e47e98c354cb2c0d82f8879d4f8fdb"
  end

  resource "markupsafe" do
    url "https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  depends_on NoExpatFramework

  def install
    if build.with? "docs"
      ENV.prepend_create_path "PYTHONPATH", buildpath+"sphinx/lib/python2.7/site-packages"
      resources.each do |r|
        r.stage do
          system "python", *Language::Python.setup_install_args(buildpath/"sphinx")
        end
      end

      # There is an existing issue around OS X & Python locale setting
      # See http://bugs.python.org/issue18378#msg215215 for explanation
      ENV["LC_ALL"] = "en_US.UTF-8"
    end

    args = %W[
      --prefix=#{prefix}
      --system-libs
      --no-system-libarchive
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
    ]

    if build.with? "docs"
      args << "--sphinx-man" << "--sphinx-build=#{buildpath}/sphinx/bin/sphinx-build"
    end

    args << "--qt-gui" if build.with? "qt"

    system "./bootstrap", *args
    system "make"
    system "make", "install"
    bin.install_symlink Dir["#{prefix}/CMake.app/Contents/bin/*"] if build.with? "qt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Ruby)")
    system "#{bin}/cmake", "."
  end
end