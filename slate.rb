require "language/node"

class Slate < Formula
  desc "Command line tool for Shopify Theme development"
  homepage "https://shopify.github.io/slate/"
  url "https://registry.npmjs.org/@shopify/slate/-/slate-0.10.0.tgz"
  sha256 "6b54d1930a3f1c72b343a07fd2800e33bc59be6e11c4773785292f33beeb2df0"
  head "https://github.com/Shopify/slate-cli.git"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
