class Libzookeeper < Formula
  desc "Centralized server for distributed coordination of services - library and headers only"
  homepage "https://zookeeper.apache.org/"

  stable do
    url "http://archive.apache.org/dist/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz"
    sha256 "2e043e04c4da82fbdb38a68e585f3317535b3842c726e0993312948afcc83870"
  end

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    cellar :any
    rebuild 1
    sha256 "c9b20ecb4b96ba7cd9a4f21557df302bfc7bacb2e6439e8a73f1d8df05ab26cb" => :sierra
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
