class Libzookeeper < Formula
  desc "Centralized server for distributed coordination of services - library and headers only"
  homepage "https://zookeeper.apache.org/"

  stable do
    url "https://www.apache.org/dyn/closer.lua?path=zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0.tar.gz"
    mirror "https://archive.apache.org/dist/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0.tar.gz"
    sha256 "cb3980f61b66babe550dcb717c940160ba813512c0aca26c2b8a718fac5d465d"
  end

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any, arm64_monterey: "698d0b4cf2320364f57f4ca1c2cbc2b0b17a61fa172cdd613a6a6fa414170728"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cppunit" => :build
  depends_on "libtool" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build

  def install
    cd "zookeeper-jute" do
      system "mvn compile"
    end

    cd "zookeeper-client/zookeeper-client-c" do
      system "autoreconf -if"
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--without-cppunit"
      system "make", "install"
    end

    rm_rf bin
  end
end
