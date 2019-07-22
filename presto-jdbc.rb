class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "http://prestodb.github.io/docs/0.222/installation/jdbc.html"
  url "http://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/0.222/presto-jdbc-0.222.jar"
  sha256 "621da8cab3b09535152b72fe1f4e4eebfb6906a9972723f8241b156d2c4678d9"
  version "0.222"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end
end
