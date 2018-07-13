cask 'tunnel-client-app' do
  version '0.2.1'
  sha256 'e3ea835ed22d4705ccaa1cc9718e5194fa7586047c5492130ec60a0fef853917'

  depends_on formula: 'oauth-tunnel-client'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/tunnel-client-app/TunnelClient.app-10ee5ff10a2d292ea63e3e7c2be1b40544cdfe1f.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
