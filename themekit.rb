class Themekit < Formula
  version 'v1.1.6'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '4c6dc8d536d70f88c70875d2dca27918a186bf2848e86bb05dccf8a3632776c6'

  def install
    bin.install 'theme'
  end
end
