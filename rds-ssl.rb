class RdsSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Connect.html"
  url "http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"
  sha256 "90567481d386dac26f4c734d83bbe8576955b2a6c84b00fc5113cdf1b7d87ea0"
  version "0.2.0"

  def install
    share.install "rds-combined-ca-bundle.pem"
  end
end
