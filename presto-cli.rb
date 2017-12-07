require_relative 'data-warehouse'

class PrestoCli < Formula
  desc "Presto CLI executable to connect and run queries against Presto"
  homepage "https://prestodb.io/docs/current/installation/cli.html"
  version get_presto_version
  url "https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/#{version}/presto-cli-#{version}-executable.jar"
  sha256 "8f6404accc90d372324b5e5abbd95b2ccecea87a4c5c3ef85804452c05679811"

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
