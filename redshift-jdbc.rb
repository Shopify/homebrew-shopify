require_relative 'data-warehouse'

class RedshiftJdbc < Formula
  desc "JAR file for connecting to Redshift over JDBC"
  homepage "https://docs.aws.amazon.com/redshift/latest/mgmt/configure-jdbc-connection.html"
  version get_redshift_jdbc_driver_version
  url "https://s3.amazonaws.com/redshift-downloads/drivers/RedshiftJDBC#{version}.jar"
  sha256 "69516aa831ae3769a468557bde2c17480b719bf9710ae71f07fc8c1a9b7ad59f"

  def install
    lib.install "RedshiftJDBC#{version}.jar"
  end
end
