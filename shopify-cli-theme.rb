require "language/node"

class ShopifyCliTheme < Formula
  desc "A CLI tool to build themes for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/theme-3.6.1.tgz"
  sha256 "38b9fe1e13cbfaa9363682fcffd33291656cd06010144573abc58d634f3b806f"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"
  depends_on "ruby"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
