class VoucherClient < Formula
  desc "Voucher Client is a tool for connecting to a running Voucher server."
  homepage "https://github.com/Shopify/voucher"
  url "https://github.com/Shopify/voucher/releases/download/v2.5.2/voucher_client_2.5.2_Darwin_x86_64.tar.gz"
  version "v2.5.2"
  sha256 "e36a04e4b52d7be9888e0810a5fccbded5e5a0bbdedd03fb52a6dbb549e3f78d"

  def install
    bin.install "voucher_client"
  end
end
