class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.6.1/darwin-amd64/theme'
  sha256 'a3ddaec8b8bc7b0dee76e905041fd28d3b9c7ea4fd0a43299cd3155f3dd51197'
  version 'v0.6.1'

  def install
    bin.install 'theme'
  end
end
