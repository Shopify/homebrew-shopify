class Themekit < Formula
  version 'v1.3.3'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 'bdacbb87420f0bc826842ce46d05e3b80196a8e46854bf3fdbf45c774fa580f9'

  def install
    bin.install 'theme'
  end
end
