class TrinoJdbc < Formula
  desc "JAR file for connecting to Trino over JDBC"
  homepage "https://trino.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-jdbc/359/trino-jdbc-359.jar"
  sha256 "8f41e467762b5bf039b59717c05bac011d5dfd0e"
  version "359"

  def install
    libexec.install "trino-jdbc-#{version}.jar"
  end

  def post_install
      lib.install_symlink "#{version}/libexec/trino-jdbc-#{version}.jar" => "../../trino-jdbc-latest.jar"
  end
end
