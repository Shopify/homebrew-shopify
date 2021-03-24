class Libzookeeper < Formula
  desc "Centralized server for distributed coordination of services - library and headers only"
  homepage "https://zookeeper.apache.org/"

  stable do
    url "http://archive.apache.org/dist/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz"
    sha256 "2e043e04c4da82fbdb38a68e585f3317535b3842c726e0993312948afcc83870"
  end

  bottle do
    cellar :any
    rebuild 2
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "d0b6bb4485c4c7870ce9864936adab5b90a015f3e3fd209fa855887e03f2fe53" => :catalina
  end

  def install
    ENV["ARCHFLAGS"] = Hardware::CPU.universal_archs.as_arch_flags

    cd "src/c" do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--without-cppunit"
      system "make", "install"
    end

    rm_rf bin
  end

end
