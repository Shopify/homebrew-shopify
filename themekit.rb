class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.8.0/darwin-amd64/theme'
  sha256 '41d1f76708ad481cf3827514c375ce342c44802944a1ec872bd4ecea1daa69c6'
  version 'v0.8.0'

  def install
    bin.install 'theme'
  end
end
