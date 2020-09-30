class Themekit < Formula
  version 'v1.1.2'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '48744b8c3af252c3f14525f21ebc884885f68431a255476067c6d449a48c39d5'

  def install
    bin.install 'theme'
  end
end
