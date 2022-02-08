class TrinoJdbc < Formula
  desc "JAR file for connecting to Trino over JDBC"
  homepage "https://trino.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-jdbc/370/trino-jdbc-370.jar"
  sha256 "8c2c5e658931af4bc1cb82e5ea5a1f05ae5769c6ac7be713c6a6a51d655b9958"
  version "370"

  def install
    libexec.install "trino-jdbc-#{version}.jar"
  end

  def post_install
    lib.install_symlink "#{version}/libexec/trino-jdbc-#{version}.jar" => "../../trino-jdbc-latest.jar"
  end
end
