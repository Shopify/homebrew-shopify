# frozen_string_literal: true

require "formula"
require "language/node"

class ShopifyCliAT3 < Formula
  desc "A CLI tool to build for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/cli-3.8.0.tgz"
  sha256 "2d61b87f454fe7ce369721e3b999b42d5499ddc85b8421032405f57b97bc0324"
  license "MIT"
  depends_on "node"
  depends_on "ruby"
  depends_on "git"

  resource "cli-theme-commands" do
    url "https://registry.npmjs.org/@shopify/theme/-/theme-3.8.0.tgz"
    sha256 "e26cfa6c503a641e3cce7be1d3c2b10fb35efab996eb871ba27baf5c07549e56"
  end

  livecheck do
    url :stable
  end

  def install
    existing_cli_path = `which shopify`
    unless existing_cli_path.empty? || existing_cli_path.include?("homebrew")
      opoo <<~WARNING
      We've detected an installation of the Shopify CLI at #{existing_cli_path} that's not managed by Homebrew.

      Please ensure that the Homebrew line in your shell configuration is at the bottom so that Homebrew-managed
      tools take precedence.
      WARNING
    end

    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]

    resource("cli-theme-commands").stage {
      system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    }
  end
end
