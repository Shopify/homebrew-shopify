class TrinoCli < Formula
  desc "Trino CLI executable to connect and run queries against Trino"
  homepage "https://trino.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/io/trino/trino-cli/381/trino-cli-381-executable.jar"
  sha256 "fb1ae6e4f976af7cb2906909d942b0cb15f9bf44e36c8d1547907be20684fe48"
  version "381"

  def install
    bin.install "trino-cli-#{version}-executable.jar" => "trino"
  end
end
