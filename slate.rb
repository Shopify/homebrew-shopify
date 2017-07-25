require "language/node"

class Slate < Formula
  desc "Command line tool for Shopify Theme development"
  homepage "https://shopify.github.io/slate/"
  url "https://registry.npmjs.org/@shopify/slate/-/slate-0.11.0.tgz"
  sha256 "e94c1ab00e6cfaf0e4738a02e5cfff4debc2e702acd5491c53ee569f11a9fdb3"
  head "https://github.com/Shopify/slate-cli.git"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
