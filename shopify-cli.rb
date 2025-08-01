# frozen_string_literal: true

require "formula"
require "language/node"
require "fileutils"

class ShopifyCli < Formula
  desc "A CLI tool to build for the Shopify platform"
  homepage "https://github.com/shopify/cli#readme"
  url "https://registry.npmjs.org/@shopify/cli/-/cli-3.83.2.tgz"
  sha256 "3ce0cae07758139b330f7f252699630d5d1aae5dcbe7dd57d3a56ed6870fa367"
  license "MIT"
  depends_on "node"
  depends_on "git"

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
    executable_path = "#{original_executable_path}"
    new_original_executable_path = "#{executable_path}-original"
    FileUtils.move(original_executable_path, new_original_executable_path)
    executable_content = <<~SCRIPT
      #!/usr/bin/env #{Formula["node"].opt_bin}/node

      process.env.SHOPIFY_HOMEBREW_FORMULA = "shopify-cli"

      import("#{new_original_executable_path}")
    SCRIPT
    File.write executable_path, executable_content
    FileUtils.chmod("+x", executable_path)

    bin.install_symlink executable_path
  end
end
