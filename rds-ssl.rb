class RdsSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Connect.html"
  url "http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"
  sha256 "d5c887be2619aa0bbc2157fc4e832041070f69d28d2a8e25fd8e8531a29ceba7"
  version "0.1.0"

  def install
    share.install "rds-combined-ca-bundle.pem"
  end
end
