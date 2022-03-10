class Svg2vd < Formula
  desc "A tool to convert Scalable Vector Graphics to Android Vector Drawables"
  homepage "https://github.com/Shopify/svg2vd"
  url "https://github.com/Shopify/svg2vd/releases/download/0.1/svg2vd-0.1.jar"
  sha256 "5b39038edf01bb424d1b16a33e29bb439fccf1ba87153eeeb9de0a486bd87471"
  version "0.1"

  def install
    lib.install "svg2vd-#{version}.jar"

    File.write("svg2vd", wrapper_script)

    bin.install "svg2vd"
  end

  def wrapper_script; <<~EOS
    #!/bin/bash
    java -jar #{lib}/svg2vd-#{version}.jar "$@"
    EOS
  end

  test do
    system "#{bin}/svg2vd", "--version"
  
    version_text = shell_output("#{bin}/svg2vd --version")
    assert_equal "svg2vd version #{version}\n", version_text
  end
end
