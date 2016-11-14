class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.5.2/darwin-amd64/theme'
  sha256 'b561884d97bd096ac6372bd6b420b09e5ff10021ddd60268a2645dc2d865e01d'
  version 'v0.5.2'

  def install
    bin.install 'theme'
  end
end
