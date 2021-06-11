class PyenvAT1211 < Formula
  desc "Python version management"
  homepage "https://github.com/pyenv/pyenv"
  url "https://github.com/pyenv/pyenv/archive/v1.2.11.tar.gz"
  sha256 "3756c0e386c3a6a6b36f2f8d6cc55441cc3aae1190f74c01f15d7dcdc0cae6fa"
  version_scheme 1
  head "https://github.com/pyenv/pyenv.git"

  bottle do
    rebuild 1
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any, catalina: "28f6c6c76c6a7cef12d0fc27c7bd19f5e8672ab30aa6946935ce00b3e2ddcf0a"
  end

  bottle do
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any, mojave: "14c889febc0ba01b956d34021afd2225ef2ef41ad4fdb2d29f7d2d077afdb6cc"
  end

  depends_on "autoconf"
  depends_on "openssl"
  depends_on "pkg-config"
  depends_on "readline"

  conflicts_with "pyenv"

  def install
    inreplace "libexec/pyenv", "/usr/local", HOMEBREW_PREFIX

    system "src/configure"
    system "make", "-C", "src"

    prefix.install Dir["*"]
    %w[pyenv-install pyenv-uninstall python-build].each do |cmd|
      bin.install_symlink "#{prefix}/plugins/python-build/bin/#{cmd}"
    end

    # Do not manually install shell completions. See:
    #   - https://github.com/pyenv/pyenv/issues/1056#issuecomment-356818337
    #   - https://github.com/Homebrew/homebrew-core/pull/22727
  end

  test do
    shell_output("eval \"$(#{bin}/pyenv init -)\" && pyenv versions")
  end
end
