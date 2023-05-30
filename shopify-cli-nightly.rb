# frozen_string_literal: true

require "formula"
require "language/node"
require "fileutils"

class ShopifyCliNightly < Formula
  desc "A CLI tool to build for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/cli-0.0.0-nightly-20230530114734.tgz"
  sha256 "76b73c079c8f5c165360ecff96e6b7e2b3d5d9ec332281e286a58e63513334ee"
  license "MIT"
  depends_on "node"
  depends_on "ruby"
  depends_on "git"

  resource "cli-theme-commands" do
    url "https://registry.npmjs.org/@shopify/theme/-/theme-0.0.0-nightly-20230530114734.tgz"
    sha256 "06e167cdf7a53d0033d310346c5fd48ed0a387a4c399f251fe3b745b37c9237e"
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

