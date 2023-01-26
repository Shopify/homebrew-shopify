# This is an older version from homebrew-core
# https://github.com/Homebrew/homebrew-core/blob/14e86a7b32195dc9568cad515dc8f4b146cb2faf/Formula/apache-spark.rb
class ApacheSparkAT312 < Formula
  desc "Engine for large-scale data processing"
  homepage "https://spark.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz"
  mirror "https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz"
  version "3.1.2"
  sha256 "0d9cf9dbbb3b4215afebe7fa4748b012e406dd1f1ad2a61b993ac04adcb94eaa"
  license "Apache-2.0"
  head "https://github.com/apache/spark.git"

  depends_on "openjdk@11"

  def install
    # Rename beeline to distinguish it from hive's beeline
    mv "bin/beeline", "bin/spark-beeline"

    rm_f Dir["bin/*.cmd"]
    libexec.install Dir["*"]
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", JAVA_HOME: Formula["openjdk@11"].opt_prefix)
  end

  test do
    assert_match "Long = 1000",
      pipe_output(bin/"spark-shell --conf spark.driver.bindAddress=127.0.0.1",
                  "sc.parallelize(1 to 1000).count()")
  end
end
