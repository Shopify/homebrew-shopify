class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.6.7/darwin-amd64/theme'
  sha256 '32c07bcda6c18bbe78ffa6280739d214cecafe7165d8435ee24aec36f8234987'
  version 'v0.6.7'

  def install
    bin.install 'theme'
  end
end
