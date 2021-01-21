class Themekit < Formula
  version 'v1.1.5'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 'fd72d6d06acdc1122e0399a25e4714e3b887053fab0b76a3fa5c97260d99af35'

  def install
    bin.install 'theme'
  end
end
