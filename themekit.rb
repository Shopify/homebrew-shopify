class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v1.0.3/darwin-amd64/theme'
  sha256 '17eda69c0f729abaf34be23ae7bb8095627d918d03c04373e321dd43a54e5a9e'
  version 'v1.0.3'

  def install
    bin.install 'theme'
  end
end
