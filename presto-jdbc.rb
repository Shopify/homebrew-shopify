require_relative 'data-warehouse'

class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "https://prestodb.io/docs/current/installation/jdbc.html"
  version get_presto_version
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/#{version}/presto-jdbc-#{version}.jar"
  sha256 "8b04760c1e07256f664f6091ec72d29b278c5e29f72d57acb31046a64ae483c7"

  def install
    lib.install "presto-jdbc-#{version}.jar"
  end
end
