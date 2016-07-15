class PrestoJdbc < Formula
  desc "JAR file for connecting to Presto over JDBC"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html#connect-using-ssl"
  url "https://s3.amazonaws.com/shopify-data-downloads/presto-jdbc-0.148-shopify.jar"
  sha256 "5776c167ec1bfb1aa98ba99746acef49fe6ac8a2ac094104ce745181717bed20"
  version "0.148-shopify"

  def install
    libexec.install "presto-jdbc-#{version}.jar"
  end
end
