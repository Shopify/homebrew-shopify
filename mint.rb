class Mint < Formula
  desc "Dependency manager that installs and runs Swift command line tool packages"
  homepage "https://github.com/jaredh/Mint"
  url "https://github.com/jaredh/Mint/archive/0.8.1.tar.gz"
  sha256 "bdea0bd5841f3fbcf32087eee3c2d683ae039b95da01fe31d52295a966a1af6e"
  head "https://github.com/jaredh/Mint.git"

  depends_on :xcode

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
