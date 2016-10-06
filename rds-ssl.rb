class RdsSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Connect.html"
  url "http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"
  sha256 "d8ef0551c3d97d91cc58dc73cd24f2f1d09d992276009d747252fc1dc2c5edef"
  version "0.2.0"

  def install
    share.install "rds-combined-ca-bundle.pem"
  end
end
