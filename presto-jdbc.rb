class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "http://prestodb.github.io/docs/0.223/installation/jdbc.html"
  url "http://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/0.223/presto-jdbc-0.223.jar"
  sha256 "44ba89800257b085e8e0fc7dd95e58f9f767fa69f543f693b6f6f58937181aa5"
  version "0.223"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end

  def post_install
      lib.install_symlink "#{version}/libexec/presto-jdbc-#{version}.jar" => "../../presto-jdbc-latest.jar"
  end
end
