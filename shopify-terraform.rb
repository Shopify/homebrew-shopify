class ShopifyTerraform < Formula
  desc "Shopify fork of Terraform"
  homepage "https://github.com/Shopify/shopify-terraform"
  url "https://s3.amazonaws.com/shopify-terraform-binaries/darwin_amd64_14f4b911024580611dbe59707d50083b61cd7283.tar.gz"
  sha256 "3ac3bdd6bfc652690b3001f7c2d12dd09d51293cd3d6c9656018936b4494f418"
  version "0.6.4-shopify-1"

  conflicts_with "terraform", :because => "both install terraform binaries"

  def install
    Dir.glob('terraform*').each { |f| bin.install f}
  end

  test do
    system "#{bin}/terraform", "version"
  end
end
