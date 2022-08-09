# frozen_string_literal: true

require "formula"

class ShopifyCliAT3 < Formula
  desc "A CLI tool to build for the Shopify platform"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "3.6.1"
  depends_on "shopify-cli-main"
  depends_on "shopify-cli-theme"
end
