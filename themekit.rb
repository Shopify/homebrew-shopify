class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.7.0/darwin-amd64/theme'
  sha256 'd1eacb00d9be43ecd534bdcac8008235ed402ee3344ae760941d34366ef6e2ab'
  version 'v0.7.0'

  def install
    bin.install 'theme'
  end
end
