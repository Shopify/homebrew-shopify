cask 'tunnel-client-app' do
  version '0.2.0'
  sha256 '39485989171b8658d64dd7b29990e13fc71a68138deca380c4cba9248acc1168'

  depends_on formula: 'oauth-tunnel-client'
  url 'https://storage.googleapis.com/tunnel-client-app-binaries/TunnelClient.app-4f9b53eb404bf23f88b131b9257aae53f7924182.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
