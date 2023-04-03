# frozen_string_literal: true

require "formula"
require "language/node"
require "fileutils"

class ShopifyCliNightly < Formula
  desc "A CLI tool to build for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/cli-0.0.0-nightly-20230403100335.tgz"
  sha256 "fcd1c3124e0c55ba2df8ad7936e2670b6127d487c0a1f5f3f8c2dfaca42d30be"
  license "MIT"
  depends_on "node"
  depends_on "ruby"
  depends_on "git"

  resource "cli-theme-commands" do
    url "https://registry.npmjs.org/@shopify/theme/-/theme-0.0.0-nightly-20230403100335.tgz"
    sha256 "188e8a04f7c829b2e039d3aa780da5d92475e5c8727a3943111bce1f6260a2bd"
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

    original_executable_path = "#{libexec}/bin/shopify"
    executable_path = "#{original_executable_path}-nightly"
    new_original_executable_path = "#{executable_path}-original"
    FileUtils.move(original_executable_path, new_original_executable_path)
    executable_content = <<~SCRIPT
      #!/usr/bin/env #{Formula["node"].opt_bin}/node

      process.env.SHOPIFY_RUBY_BINDIR = "#{Formula["ruby"].opt_bin}"
      process.env.SHOPIFY_HOMEBREW_FORMULA = "shopify-cli-nightly"

      import("#{new_original_executable_path}")
    SCRIPT
    File.write executable_path, executable_content
    FileUtils.chmod("+x", executable_path)

    bin.install_symlink executable_path

    resource("cli-theme-commands").stage {
      system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    }
  end
end

