cask 'tunnel-client-app' do
  version '0.1.0'
  sha256 '562ff71232d120ae64e2be9f683296687d8a1c5f9e1cfb3d8ee315b1e57ac205'

  url 'https://storage.googleapis.com/tunnel-client-app-binaries/TunnelClient.app-430b1d1967a808ad919f43a3617bb74f595bb528.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
