class Themekit < Formula
  version 'v1.1.5'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '483a660c655cfad28787106bcaea3c52d09ee1dcd8007e05007d223ae8aaf4ea'

  def install
    bin.install 'theme'
  end
end
