# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ShopifyLibfaketime < Formula
  desc "Report faked system time to programs"
  homepage "https://github.com/wolfcw/libfaketime/"
  url "https://github.com/wolfcw/libfaketime/archive/macos-sierra.zip"
  version "sierra"
  sha256 "a1123197e4c6ccf446131f5347e5505eb1cfc85451533c1247a9c444a77d53b6"

  depends_on :macos => :sierra

  def install
    system "make", "-C", "src", "-f", "Makefile.OSX", "PREFIX=#{prefix}"
    bin.install "src/faketime"
    (lib/"faketime").install "src/libfaketime.1.dylib"
    man1.install "man/faketime.1"
  end
end
