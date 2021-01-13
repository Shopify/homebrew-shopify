class Themekit < Formula
  version 'v1.1.4'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '096dab12252132907fe47f7803bcea99c15607e9d208269c1264b0c84222a31e'

  def install
    bin.install 'theme'
  end
end
