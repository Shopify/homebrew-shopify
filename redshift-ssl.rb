class RedshiftSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html#connect-using-ssl"
  url "https://s3.amazonaws.com/redshift-downloads/redshift-ssl-ca-cert.pem"
  sha256 "66fdaaa6ea623fce7052c5b77948d1482317f27076040100167840d3fa2bb449"
  version "0.1.0"

  def install
    share.install "redshift-ssl-ca-cert.pem"
  end
end
