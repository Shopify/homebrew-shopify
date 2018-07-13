cask 'tunnel-client-app' do
  version '0.2.1'
  sha256 '11482026db39f8e42752c86b68169785d931d75429aaa61baed3aa2083027571'

  depends_on formula: 'oauth-tunnel-client'
  url 'https://storage.googleapis.com/binaries.shopifykloud.com/tunnel-client-app/TunnelClient.app-95464a4ab5166a2b96dee9d0aa7586e2e6a12c66.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
