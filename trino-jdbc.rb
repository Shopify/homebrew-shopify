class TrinoJdbc < Formula
  desc "JAR file for connecting to Trino over JDBC"
  homepage "https://trino.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-jdbc/381/trino-jdbc-381.jar"
  sha256 "147aa35d016eeb14e0dea957f13692ec9fdb2398080d4ac4a164e1de28f3366b"
  version "381"

  def install
    libexec.install "trino-jdbc-#{version}.jar"
  end

  def post_install
    lib.install_symlink "#{version}/libexec/trino-jdbc-#{version}.jar" => "../../trino-jdbc-latest.jar"
  end
end
