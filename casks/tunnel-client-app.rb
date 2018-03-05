cask 'tunnel-client-app' do
  version '0.1.0'
  sha256 'ef1398a235b6e1d7ad2fd7e0a9d5dbf3d1b5a086bb171cc615943bae244fea29'

  url 'https://storage.googleapis.com/tunnel-client-app-binaries/TunnelClient.app-c1382d0e6f4607b9739a0422468000536491f0e8.tar.gz'
  name 'Tunnel Client App'
  homepage 'https://github.com/Shopify/tunnel-client-app'

  app 'TunnelClient.app'
end
