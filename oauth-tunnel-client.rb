class OauthTunnelClient < Formula
  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://github.com/Shopify/oauth-tunnel-client/archive/v0.1-alpha.tar.gz'
  sha256 '25a453dce46fcd4a696f756a883864eec0021ca8'

  depends_on 'go' => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/Shopify/oauth-tunnel-client").install buildpath.children
    cd "src/github.com/Shopify/oauth-tunnel-client" do
      system "go", "build", "-o", bin/"oauth-tunnel-client"
    end
  end
end
