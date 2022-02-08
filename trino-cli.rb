class TrinoCli < Formula
  desc "Trino CLI executable to connect and run queries against Trino"
  homepage "https://trino.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-cli/370/trino-cli-370-executable.jar"
  sha256 "9e8b66175b9716ca942ac63b24f62ebdcc7d47e1b39a0b5c124c89db31c2b9b4"
  version "370"

  def install
    bin.install "trino-cli-#{version}-executable.jar" => "trino"
  end
end
