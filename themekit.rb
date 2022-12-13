class Themekit < Formula
  version 'v1.3.1'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 'c7ff4626d0dd680d13c3113f4c84a069bf7640b5ac7ed05ab6e1c48ddfa064f5'

  def install
    bin.install 'theme'
  end
end
