class Mint < Formula
  desc "Dependency manager that installs and runs Swift command line tool packages"
  homepage "https://github.com/g-Off/Mint"
  url "https://github.com/g-Off/Mint/archive/0.8.0.tar.gz"
  sha256 "3b32522f7f65a4e0fe9e186bc9f9d1ad455333eb610f837d59d97aa3f7cb0801"
  head "https://github.com/g-Off/Mint.git"

  depends_on :xcode

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
