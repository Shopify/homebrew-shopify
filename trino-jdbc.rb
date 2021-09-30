class TrinoJdbc < Formula
  desc "JAR file for connecting to Trino over JDBC"
  homepage "https://trino.io/docs/current/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-jdbc/362/trino-jdbc-362.jar"
  sha256 "740525691b46dfe389fc597e13007b81a77f3911dc88154d8dec397aa2b1e86d"
  version "362"

  def install
    libexec.install "trino-jdbc-#{version}.jar"
  end

  def post_install
    lib.install_symlink "#{version}/libexec/trino-jdbc-#{version}.jar" => "../../trino-jdbc-latest.jar"
  end
end
