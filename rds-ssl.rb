class RdsSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Connect.html"
  url "http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"
  sha256 "026a9420e4e6fefa882ce1d65a2bf0037946d83ff4becd089c4cca88a1af9bd7"
  version "0.2.0"

  def install
    share.install "rds-combined-ca-bundle.pem"
  end
end
