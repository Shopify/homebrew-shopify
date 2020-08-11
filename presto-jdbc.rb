class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "https://prestosql.io/docs/336/installation/jdbc.html"
  url "https://repo1.maven.org/maven2/io/prestosql/presto-jdbc/336/presto-jdbc-336.jar"
  sha256 "fc7794d5a44ebf9619267da0b6bd75dad7dea660752d4964200dbec023d8cb49"
  version "336"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end

  def post_install
      lib.install_symlink "#{version}/libexec/presto-jdbc-#{version}.jar" => "../../presto-jdbc-latest.jar"
  end
end
