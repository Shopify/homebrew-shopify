class ShopifyTerraform < Formula
  desc "Shopify fork of Terraform"
  homepage "https://github.com/Shopify/shopify-terraform"
  url "https://s3.amazonaws.com/shopify-terraform-binaries/darwin_amd64_2265c81e16f3d44b0be158bd4cd29a6eaf0a8caf.tar.gz"
  sha256 "7fe5945df5d75ce25c2c8a67a1064389218d59993addb95f2e0ec26d0a778b01"
  version "0.6.7-shopify"

  conflicts_with "terraform", :because => "both install terraform binaries"

  def install
    Dir.glob('terraform*').each { |f| bin.install f }
  end

  test do
    system "#{bin}/terraform", "version"
  end
end
