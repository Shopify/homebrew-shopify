class VoucherClient < Formula
  desc "Voucher Client is a tool for connecting to a running Voucher server."
  homepage "https://github.com/Shopify/voucher"
  url "https://github.com/Shopify/voucher/releases/download/v2.5.2/voucher_client_2.5.2_Darwin_x86_64.tar.gz"
  version "v2.5.2"
  sha256 "f2d121409fe6d7619497be6efd68daca1aaeb0ffcd9d054b389fbdb95b5f48a8"

  def install
    bin.install "voucher_client"
  end
end
