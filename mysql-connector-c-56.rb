require 'formula'

class MysqlConnectorC56 < Formula
  homepage 'http://dev.mysql.com/downloads/connector/c/'
  url 'http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.23-osx10.9-x86_64.tar.gz'
  sha1 'd70392aafb9ddeddd797c8131898e8727f904898'

  depends_on 'cmake' => :build

  conflicts_with 'mysql', 'mariadb', 'percona-server',
    :because => 'both install MySQL client libraries'

  fails_with :llvm do
    build 2334
    cause "Unsupported inline asm"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system 'make'
    ENV.j1
    system 'make install'
  end
end