# frozen_string_literal: true

require "formula"
require "language/node"
require "fileutils"

class ShopifyCliAT3 < Formula
  desc "A CLI tool to build for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/cli-3.9.1.tgz"
  sha256 "c474b45e3d9b676b3ea7550db3530a385405fe4dfeae242fac22112349975d09"
  license "MIT"
  depends_on "node"
  depends_on "ruby"
  depends_on "git"

  resource "cli-theme-commands" do
    url "https://registry.npmjs.org/@shopify/theme/-/theme-3.9.1.tgz"
    sha256 "7fae6db4c06320bbf0614828b0c1ab811e6289dd39240e619ab0cc335fbee568"
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

    executable_path = "#{libexec}/bin/shopify3"
    executable_content = <<~SCRIPT
      #!/usr/bin/env node

      process.env.SHOPIFY_RUBY_BINDIR = Formula["ruby"].opt_bin

      import("./shopify");
    SCRIPT
    File.write executable_path, executable_content
    FileUtils.chmod("+x", executable_path)

    bin.install_symlink executable_path

    resource("cli-theme-commands").stage {
      system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    }
  end
end
