class TrinoJdbc < Formula
  desc "JAR file for connecting to Trino over JDBC"
  homepage "https://trino.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-jdbc/359/trino-jdbc-359.jar"
  sha256 "4ec6a83ccf9cdcab60aed0eca644f9a8a8cec256d0a2fc9e00a298be6d054098"
  version "359"

  def install
    libexec.install "trino-jdbc-#{version}.jar"
  end

  def post_install
    lib.install_symlink "#{version}/libexec/trino-jdbc-#{version}.jar" => "../../trino-jdbc-latest.jar"
  end
end
