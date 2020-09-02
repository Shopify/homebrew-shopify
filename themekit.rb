class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v1.1.1/darwin-amd64/theme'
  sha256 '4b70165660e817e8d6a8f5f1ac8aca5f38ae9f77231f8ea53cc4f42700514a0a'
  version 'v1.0.3'

  def install
    bin.install 'theme'
  end
end
