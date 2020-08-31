class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v1.1.0/darwin-amd64/theme'
  sha256 '097056b2ec18281fea3f52993d4c6d0ed63c9ccaa028cd72b354c6265e7f43c4'
  version 'v1.0.3'

  def install
    bin.install 'theme'
  end
end
