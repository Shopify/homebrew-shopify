class RdsSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Aurora.Connect.html"
  url "http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"
  sha256 "58c92aea3a96591abdd0c6ebb4116d9e33af946196bc1e43196961b1b0eac415"
  version "0.2.0"

  def install
    share.install "rds-combined-ca-bundle.pem"
  end
end
