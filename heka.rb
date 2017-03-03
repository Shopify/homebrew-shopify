class Heka < Formula
  homepage "https://github.com/mozilla-services/heka"
  url "https://github.com/mozilla-services/heka.git",
    :tag => "v0.10.0", :revision => "056da2d21d7b842493508872eeca135537baf396"

  head "https://github.com/mozilla-services/heka.git"

  depends_on "go@1.4" => :build # heka needs 1.4 to build
  depends_on "lua"   => :build
  depends_on "cmake30" => :build

  def install
    system "bash -c 'source build.sh  && make install'"
    cp_r (buildpath/"build/heka").children, prefix
  end
end

