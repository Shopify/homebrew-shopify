class Libzookeeper < Formula
  desc "Centralized server for distributed coordination of services - library and headers only"
  homepage "https://zookeeper.apache.org/"

  stable do
    url "https://www.apache.org/dyn/closer.cgi?path=zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz"
    sha256 "2e043e04c4da82fbdb38a68e585f3317535b3842c726e0993312948afcc83870"
  end

  bottle do
    root_url "http://burkelibbey.s3.amazonaws.com"
    cellar :any
    sha256 "20f915a20fb978941bb52af74b50c4cea5b09ce21caee078cb83a8a7671b073e" => :el_capitan
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
