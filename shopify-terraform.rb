class ShopifyTerraform < Formula
  desc "Shopify fork of Terraform"
  homepage "https://github.com/Shopify/shopify-terraform"
  url "https://s3.amazonaws.com/shopify-terraform-binaries/darwin_amd64_c2617c96cd3c8369981715b115173de7157f2809.tar.gz"
  sha256 "82418314cdd2fd92371121e6fb029f363dfc538aab09493a6b7c4e64e55f2e0f"
  version "0.6.7-pre-shopify"

  conflicts_with "terraform", :because => "both install terraform binaries"

  def install
    Dir.glob('terraform*').each { |f| bin.install f }
  end

  test do
    system "#{bin}/terraform", "version"
  end
end
