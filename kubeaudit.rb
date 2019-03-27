class Kubeaudit < Formula
  desc "kubeaudit helps you audit your Kubernetes clusters against common security controls"
  homepage "https://github.com/Shopify/kubeaudit"
  url "https://github.com/Shopify/kubeaudit/releases/download/v0.5.2/kubeaudit_0.5.2_darwin_amd64.tar.gz"
  sha256 "8748d00ef280691ca8ec70bb30b69c4deb172245ec9d39b1d6a2f31aef1bfb4a"
  def install
    bin.install "kubeaudit"
  end
end
