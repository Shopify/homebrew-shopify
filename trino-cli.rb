class TrinoCli < Formula
  desc "Trino CLI executable to connect and run queries against Trino"
  homepage "https://trino.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-cli/359/trino-cli-359-executable.jar"
  sha256 "ee6b44147dcdef3c23fff6b043f5a175e93e8d403dc90372ebaf59f856c1bd49"
  version "359"

  def install
    lib.install "trino-cli-#{version}-executable.jar"
    bin.install "trino"
  end
end
