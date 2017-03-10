class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.6.10/darwin-amd64/theme'
  sha256 'b6804ffcc6f1bc01c2e46a5dafcd43d20aed6f28c71121f49bcb51618aae03e1'
  version 'v0.6.10'

  def install
    bin.install 'theme'
  end
end
