class RedshiftSsl < Formula
  desc "Root public key for Amazon redshift SSL connectivity"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html#connect-using-ssl"
  url "https://s3.amazonaws.com/redshift-downloads/redshift-ssl-ca-cert.pem"
  sha256 "e77daa6243a940eb2d144d26757135195b4bdefd345c32a064d4ebea02b9f8a1"
  version "0.1.0"

  def install
    share.install "redshift-ssl-ca-cert.pem"
  end
end
