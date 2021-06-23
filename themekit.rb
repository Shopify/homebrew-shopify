class Themekit < Formula
  version 'v1.3.0'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '5b091f20bddf97bba167bb029ce74d5236d824fa4e210e549b7c2d06941018e5'

  def install
    bin.install 'theme'
  end
end
