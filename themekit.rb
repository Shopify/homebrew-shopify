class Themekit < Formula
  version 'v1.2.0'
  desc 'Theme Kit is a tool kit for manipulating shopify themes'
  homepage 'https://shopify.github.io/themekit/'
  url "https://shopify-themekit.s3.amazonaws.com/#{version}/darwin-amd64/theme"
  sha256 '5563591b36b9eb0e63ae7496d9ab9a08056d123ad81d2abf03e1bdac9ffd64ad'

  def install
    bin.install 'theme'
  end
end
