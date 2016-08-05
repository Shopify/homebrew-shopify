class PrestoCli < Formula
  desc "Presto CLI executable to connect and run queries against Presto"
  homepage "https://prestodb.io/docs/current/installation/cli.html"
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.151/presto-cli-0.151-executable.jar"
  sha256 "cf7032e820e88cce76e2cc92710a5bf82c459588c2d628165d084438e18a35ff"
  version "0.151"

  def install
    lib.install "presto-cli-#{version}-executable.jar"

    File.write("presto", wrapper_script)

    bin.install "presto"
  end

  def wrapper_script; <<-EOS.undent
    #!/bin/bash

    java -Duser.timezone=UTC -jar #{lib}/presto-cli-#{version}-executable.jar --user $(whoami) --server ods1.hu131.data-chi.shopify.com:8082 "$@"
    EOS
  end
end
