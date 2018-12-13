class VoucherClient < Formula
  desc "Voucher Client is a tool for connecting to a running Voucher server."
  homepage "https://github.com/Shopify/voucher"
  url "https://github.com/Shopify/voucher/releases/download/v1.0.0/voucher_1.0.0_Darwin_x86_64.tar.gz"
  version "v1.0.0"
  sha256 "8389111183a09701b9c3442e22481432d3eac31f287402beaebaab1f20defdea"

  def install
    bin.install "voucher_client"
  end
end
