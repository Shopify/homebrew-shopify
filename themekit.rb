class Themekit < Formula
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url 'https://shopify-themekit.s3.amazonaws.com/v0.6.4/darwin-amd64/theme'
  sha256 '00781aaf68767e1cfebec819dd282c710950d31a47fcfb651ef557568cbe6a48'
  version 'v0.6.4'

  def install
    bin.install 'theme'
  end
end
