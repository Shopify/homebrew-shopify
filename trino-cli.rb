class TrinoCli < Formula
  desc "Trino CLI executable to connect and run queries against Trino"
  homepage "https://trino.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-cli/362/trino-cli-362-executable.jar"
  sha256 "3fe3ec6d003aaceeb2b0c2701b02409c2254a7321fd49ceb8c6d123a5e444ba4"
  version "362"

  def install
    bin.install "trino-cli-#{version}-executable.jar" => "trino"
  end
end
