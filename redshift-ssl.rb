class RedshiftSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html#connect-using-ssl"
  url "https://s3.amazonaws.com/redshift-downloads/redshift-ssl-ca-cert.pem"
  sha256 "f63b3098250346eee57b63a2b150cb4fd75c3bb70bdd36bc1ac7de6d462499e4"
  version "0.1.0"

  def install
    share.install "redshift-ssl-ca-cert.pem"
  end
end
