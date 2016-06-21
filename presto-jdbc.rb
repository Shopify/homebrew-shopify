class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html#connect-using-ssl"
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/0.148/presto-jdbc-0.148.jar"
  sha256 "568d13a4957c5555c1809988a260cf83b9475ce9c928f0e24a3f09612594279b"
  version "0.148"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end
end
