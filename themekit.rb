class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.7.5/darwin-amd64/theme'
  sha256 '0386ec0d816659882e1f2a4e80b4181145f3f2f5303c1e027439b15e3d677739'
  version 'v0.7.5'

  def install
    bin.install 'theme'
  end
end
