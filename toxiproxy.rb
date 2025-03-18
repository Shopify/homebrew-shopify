# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Toxiproxy < Formula
  app_version = "2.12.0"
  homepage "https://github.com/Shopify/toxiproxy"
  license "MIT"
  version app_version

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-amd64"
    sha256 "9625bba4bd96117eedae49f982aba4c2f462b268dd406c9ff18186f9b1ef8afe"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-darwin-arm64"
    sha256 "aa299966b52f16a8594f1cd0d1e9049dc2e8fe2c04a90c19860e2719b2b95d15"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-amd64"
    sha256 "556d891134a3c582dc1e1a3f7335fd55142e5965769855a00b944e13e48302fc"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-server-linux-arm64"
    sha256 "53e770c1c3035b5a9f1bc629fce537db1f95f62b26f4ebe6e756afd701cf077c"
  else
    odie "Unexpected platform!"
  end

  resource "cli" do
    case
    when OS.mac? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-amd64"
      sha256 "024331f82b086de0deb1c3553f36e1a51334dbc5e3d6af3e78757fc86b22be9c"
    when OS.mac? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-darwin-arm64"
      sha256 "7a68472cbfc6b317fed8abaa5e31e1adf66b0eeaf38162b167748f1369fef039"
    when OS.linux? && Hardware::CPU.intel?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-amd64"
      sha256 "26c747024a3758a243c4449ff4f65634983fe98a0ab411d242cc9ff4561312b4"
    when OS.linux? && Hardware::CPU.arm?
      url "https://github.com/Shopify/toxiproxy/releases/download/v#{app_version}/toxiproxy-cli-linux-arm64"
      sha256 "4f2d894c624ee100b5d2df1cc7c6d3a1dbc7563f641bfd937db5de504f211afa"
    end
  end

  test do
    resource("cli").stage do
      assert_match "toxiproxy-cli version #{app_version}", shell_output("#{bin}/toxiproxy-cli --version")
    end
  end

  def install
    host_os = OS.mac? ? "darwin" : "linux"
    host_arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    platform = "#{host_os}-#{host_arch}"

    bin.install "toxiproxy-server-#{platform}" => "toxiproxy-server"
    resource("cli").stage do
      bin.install "toxiproxy-cli-#{platform}" => "toxiproxy-cli"
    end
  end

  service do
    run [bin/"toxiproxy-server"]
    keep_alive true
  end
end
