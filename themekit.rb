class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.6.12/darwin-amd64/theme'
  sha256 'b5f3698d2080b2490981b5191de42e57002af6cc5ed111a7d3d452b8ec881bac'
  version 'v0.6.12'

  def install
    bin.install 'theme'
  end
end
