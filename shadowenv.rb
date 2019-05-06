class Shadowenv < Formula
  desc "Reversible directory-local environment variable manipulations"
  homepage "https://shopify.github.io/shadowenv/"
  url "https://github.com/Shopify/shadowenv/archive/0.3.1.tar.gz"
  sha256 "303d0537c37fd02f6c75e6c65fa7662c5a9d8c939548cd1c02b1b1fb746cd560"

  depends_on "rustup-init" => :build

  def install
    system "rustup-init", "-y"
    ENV["PATH"] = "#{ENV["CARGO_HOME"]}/bin:#{ENV["PATH"]}"
    system "rustup", "toolchain", "install", "nightly-2018-12-26"
    system "cargo", "+nightly-2018-12-26", "install", "--root", prefix, "--path", "."
    man1.install "#{buildpath}/man/man1/shadowenv.1"
    man5.install "#{buildpath}/man/man5/shadowlisp.5"
  end

  test do
    assert_equal "shadowenv 0.3.1", shell_output("#{bin}/shadowenv -V").chomp
  end
end
