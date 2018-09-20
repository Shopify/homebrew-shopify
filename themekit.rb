class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.8.1/darwin-amd64/theme'
  sha256 '0e21427a6023b4b265956e8005c0589b8d14865359096b956b5c4faaf1e975b3'
  version 'v0.8.1'

  def install
    bin.install 'theme'
  end
end
