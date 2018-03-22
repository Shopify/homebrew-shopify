class PrestoCli < Formula
  desc "Presto CLI executable to connect and run queries against Presto"
  homepage "https://prestodb.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.151/presto-cli-0.151-executable.jar"
  sha256 "7d8cde7a38080a08425445e200dc7ecb26635204c32769a59277133bf6328fbb"
  version "0.151"

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
