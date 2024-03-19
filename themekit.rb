class Themekit < Formula
  version 'v1.3.2'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 'c81af2eb4e8c1f55c05c11a5d6716e2e651712f198e99b8c85da277a06a2dc8e'

  def install
    bin.install 'theme'
  end
end
