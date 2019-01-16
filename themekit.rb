class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v1.0.0/darwin-amd64/theme'
  sha256 '2105cea9086fde0b6a43ff4b63ab451b5a6619333f9a6e4844e9e1a98b3accdd'
  version 'v1.0.0'

  def install
    bin.install 'theme'
  end
end
