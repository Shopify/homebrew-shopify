cask 'tunnel-client-app' do
  version '1.0.0'
  sha256 'bc8dcb14d803e098facb1373e37123bcd74a24cc2667167c7953a09f3819e985'

  url 'https://storage.googleapis.com/tunnel-client-app-binaries/TunnelClient.app.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
