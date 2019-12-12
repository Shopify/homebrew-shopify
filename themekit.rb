class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v1.0.2/darwin-amd64/theme'
  sha256 '4b734d08db62e001adcf8ac5607414aa9cb6cfb410faa8f53b02f9f5c8a5733c'
  version 'v1.0.2'

  def install
    bin.install 'theme'
  end
end
