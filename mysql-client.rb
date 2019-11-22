class MysqlClient < Formula
  desc "Open source relational database management system"
  homepage "https://dev.mysql.com/doc/refman/5.7/en/"
  url "https://src.fedoraproject.org/repo/pkgs/community-mysql/mysql-5.7.10.tar.gz/aabc96e8628228014479f7233d076877/mysql-5.7.10.tar.gz"
  sha256 "1ea1644884d086a23eafd8ccb04d517fbd43da3a6a06036f23c5c3a111e25c74"

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    rebuild 1
    sha256 "6c1ca55896635994d1fac5cbc2703062443515d4eaa676d1251ab7a9a40d943a" => :sierra
  end

  bottle do
    rebuild 2
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "6107451cb3315bee712b4f9102fbd8da5528fb4b4b2d5bb40e277ab3c21764ce" => :catalina
  end

  bottle do
    rebuild 3
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "d29a632d2f300d5b583a7b1ff0534fc21547762e5a6d03d89fa5b28b31c733f5" => :mojave
    sha256 "e96b0f67ee3a67c98a9b94b9a04d4168efa011062f9afa4cd1a0f7fba356c337" => :catalina
  end

  depends_on "cmake" => :build
  depends_on "shopify/shopify/openssl"

  conflicts_with "mysql", "mariadb", "percona-server",
    :because => "mysql-client, mysql, mariadb, and percona install the same binaries."
  conflicts_with "mysql-connector-c",
    :because => "both install MySQL client libraries"
  conflicts_with "mariadb-connector-c",
    :because => "both install plugins"

  resource "boost" do
    url "https://storage.googleapis.com/shopify-dev-public/boost_1_59_0.tar.bz2"
    sha256 "727a932322d94287b62abb1bd2d41723eec4356a7728909e38adb65ca25241ca"
  end

  def datadir
    var/"mysql"
  end

  def install
    # Don't hard-code the libtool path. See:
    # https://github.com/Homebrew/homebrew/issues/20185
    inreplace "cmake/libutils.cmake",
      "COMMAND /usr/bin/libtool -static -o ${TARGET_LOCATION}",
      "COMMAND libtool -static -o ${TARGET_LOCATION}"

    # -DINSTALL_* are relative to `CMAKE_INSTALL_PREFIX` (`prefix`)
    args = %W[
      .
      -DWITHOUT_SERVER=1
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_FIND_FRAMEWORK=LAST
      -DCMAKE_VERBOSE_MAKEFILE=ON
      -DMYSQL_DATADIR=#{datadir}
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_MANDIR=share/man
      -DINSTALL_DOCDIR=share/doc/#{name}
      -DINSTALL_INFODIR=share/info
      -DINSTALL_MYSQLSHAREDIR=share/mysql
      -DWITH_SSL=yes
      -DWITH_SSL=system
      -DDEFAULT_CHARSET=utf8
      -DDEFAULT_COLLATION=utf8_general_ci
      -DSYSCONFDIR=#{etc}
      -DCOMPILATION_COMMENT=Homebrew
      -DWITH_EDITLINE=system
    ]

    # MySQL >5.7.x mandates Boost as a requirement to build & has a strict
    # version check in place to ensure it only builds against expected release.
    # This is problematic when Boost releases don't align with MySQL releases.
    (buildpath/"boost_1_59_0").install resource("boost")
    args << "-DWITH_BOOST=#{buildpath}/boost_1_59_0"

    system "cmake", *args
    system "make"
    system "make", "install"

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix/"data"
  end
end
