class ShopifyTerraform < Formula
  desc "Shopify fork of Terraform"
  homepage "https://github.com/Shopify/shopify-terraform"
  url "https://s3.amazonaws.com/shopify-terraform-binaries/darwin_amd64_1872f858e30f77a1febce91fe375400e773213ef.tar.gz"
  sha256 "d8096413e8103312a5d650ed15e7df734faa9cdafab0428ae1dc759bd837d69b"
  version "0.7.13-shopify"

  conflicts_with "terraform", :because => "both install terraform binaries"

  def install
    Dir.glob('terraform*').each { |f| bin.install f }
  end

  test do
    system "#{bin}/terraform", "version"
  end
end
