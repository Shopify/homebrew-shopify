class HiveAT237 < Formula
  desc "Hadoop-based data summarization, query, and analysis"
  homepage "https://hive.apache.org"
  url "https://archive.apache.org/dist/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz"
  sha256 "e55149b0ca1181931b0538d7012ac3b0e5b022bf26ed06fe1709cd2e5d2be5bb"

  depends_on "openjdk@11"
  depends_on "hadoop"

  def install
    rm_f Dir["bin/*.cmd", "bin/ext/*.cmd", "bin/ext/util/*.cmd"]
    libexec.install %w[bin conf examples hcatalog lib scripts]

    Pathname.glob("#{libexec}/bin/*") do |file|
      next if file.directory?
      (bin/file.basename).write_env_script file,
        Language::Java.java_home_env("1.7+").merge(:HIVE_HOME => libexec)
    end
  end

  def caveats; <<~EOS
    Hadoop must be in your path for hive executable to work.

    If you want to use HCatalog with Pig, set $HCAT_HOME in your profile:
      export HCAT_HOME=#{opt_libexec}/hcatalog
  EOS
  end

  test do
    system bin/"schematool", "-initSchema", "-dbType", "derby"
    assert_match "Hive #{version}", shell_output("#{bin}/hive --version")
  end
end
