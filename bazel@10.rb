class BazelAT10 < Formula
  desc "Google's own build tool"
  homepage "https://bazel.build/"
  url "https://github.com/bazelbuild/bazel/releases/download/0.10.1/bazel-0.10.1-dist.zip"
  sha256 "708248f6d92f2f4d6342006c520f22dffa2f8adb0a9dc06a058e3effe7fee667"

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    sha256 cellar: :any_skip_relocation, high_sierra: "d7b4922e6975445039caa632c3bc1490cfad8561a7b16dc26b0d875aac168323"
  end

  bottle do
    rebuild 1
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 cellar: :any_skip_relocation, catalina: "13a977fbb0910b5ef04baec6476c8c99c0844ba58f3486ad189a2fd69f7c1fcb"
  end

  depends_on "openjdk@8"
  depends_on :macos => :el_capitan

  def install
    ENV["EMBED_LABEL"] = "#{version}-homebrew"
    # Force Bazel ./compile.sh to put its temporary files in the buildpath
    ENV["BAZEL_WRKDIR"] = buildpath/"work"

    system "./compile.sh"
    system "./output/bazel", "--output_user_root", buildpath/"output_user_root",
           "build", "scripts:bash_completion"

    bin.install "scripts/packages/bazel.sh" => "bazel"
    bin.install "output/bazel" => "bazel-real"
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))

    bash_completion.install "bazel-bin/scripts/bazel-complete.bash"
    zsh_completion.install "scripts/zsh_completion/_bazel"
  end

  test do
    touch testpath/"WORKSPACE"

    (testpath/"ProjectRunner.java").write <<~EOS
      public class ProjectRunner {
        public static void main(String args[]) {
          System.out.println("Hi!");
        }
      }
    EOS

    (testpath/"BUILD").write <<~EOS
      java_binary(
        name = "bazel-test",
        srcs = glob(["*.java"]),
        main_class = "ProjectRunner",
      )
    EOS

    system bin/"bazel", "build", "//:bazel-test"
    system "bazel-bin/bazel-test"
  end
end
