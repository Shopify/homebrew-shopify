class TrinoCli < Formula
  desc "Trino CLI executable to connect and run queries against Presto"
  homepage "https://trino.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-cli/359/trino-cli-359-executable.jar"
  sha256 "ff7ad5004b47eb5a1d2f40d122efa5b053c9cebb"
  version "359"

  def install
    lib.install "trino-cli-#{version}-executable.jar"

    File.write("trino", wrapper_script)

    bin.install "trino"
  end
end
