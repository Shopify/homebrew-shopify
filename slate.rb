require "language/node"

class Slate < Formula
  desc "Command line tool for Shopify Theme development"
  homepage "https://shopify.github.io/slate/"
  url "https://registry.npmjs.org/@shopify/slate/-/slate-0.13.0.tgz"
  sha256 "d58b314eae94183764a0096fc97d6da933cbd618402e6655a5dfeb0b2ea17913"
  head "https://github.com/Shopify/slate/tree/master/packages/slate-cli"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
