class RedshiftCa < Formula
  desc "Amazon Redshift certificate authority bundle for SSL connectivity"
  homepage "http://docs.aws.amazon.com/redshift/latest/mgmt/connecting-transitioning-to-acm-certs.html#connecting-transitioning-to-acm-other-ssl-types"
  url "https://s3.amazonaws.com/redshift-downloads/redshift-ca-bundle.crt"
  sha256 "e77daa6243a940eb2d144d26757135195b4bdefd345c32a064d4ebea02b9f8a1"

  def install
    share.install "redshift-ca-bundle.crt"
  end
end
