class ShopifyTerraform < Formula
  desc "Shopify fork of Terraform"
  homepage "https://github.com/Shopify/shopify-terraform"
  url "https://s3.amazonaws.com/shopify-terraform-binaries/darwin_amd64_d9349fd80c39c9435ab5212279cc4befce589019.tar.gz"
  sha256 "f5bbb7dabe0c400e60b62cc3cc46de886e3996cfb14ffde2365a623b9548ab77"
  version "0.7.7-shopify"

  conflicts_with "terraform", :because => "both install terraform binaries"

  def install
    Dir.glob('terraform*').each { |f| bin.install f }
  end

  test do
    system "#{bin}/terraform", "version"
  end
end
