class PrestoCli < Formula
  desc "Presto CLI executable to connect and run queries against Presto"
  homepage "https://prestodb.io/docs/0.222/installation/cli.html"
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.222/presto-cli-0.222-executable.jar"
  sha256 "731397ebe97413f402fb92bcd87dd9639f0844a5dfe52d6dcc69eb4c221362a5"
  version "0.222"


  def install
    lib.install "presto-cli-#{version}-executable.jar"

    File.write("presto", wrapper_script)

    bin.install "presto"
  end

  def wrapper_script; <<~EOS
    #!/bin/bash

    java -Duser.timezone=UTC -jar #{lib}/presto-cli-#{version}-executable.jar --user $(whoami) --server presto-for-datachi.presto.tunnel.shopifykloud.com:8675 "$@"
    EOS
  end
end
