class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "https://prestosql.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/prestosql/presto-jdbc/338/presto-jdbc-338.jar"
  sha256 "3b96c19ec74909c7da4856eb7ff3f4bdff3965ce462826a3b74d5e405ff85754"
  version "338"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end

  def post_install
      lib.install_symlink "#{version}/libexec/presto-jdbc-#{version}.jar" => "../../presto-jdbc-latest.jar"
  end
end
