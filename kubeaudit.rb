class Kubeaudit < Formula
  desc "kubeaudit helps you audit your Kubernetes clusters against common security controls"
  homepage "https://github.com/shopify/kubeaudit"
  url "https://github.com/Shopify/kubeaudit/releases/download/v0.5.1/kubeaudit_0.5.1_darwin_amd64.tar.gz"
  sha256 "eed75fb8cf094f2cf9e1cc422f4df9ebab51c43b68d62c60f6c712b9bbee1d21"
  def install
    bin.install "kubeaudit"
  end
end
