class Heka < Formula
  homepage "https://github.com/mozilla-services/heka"
  url "https://github.com/mozilla-services/heka.git",
    :tag => "v0.10.0", :revision => "056da2d21d7b842493508872eeca135537baf396"

  head "https://github.com/mozilla-services/heka.git"

  depends_on "homebrew/versions/go14" => :build # heka needs 1.4 to build
  depends_on "go" => :build # heka's 'mockgen' is hardcoded for 'go' - https://github.com/rafrombrc/gomock/blob/master/mockgen/reflect.go#L75
  depends_on "cmake30" => :build

  def install
    system "bash -c 'source build.sh && make install'"
    cp_r (buildpath/"build/heka").children, prefix
  end

  patch :DATA
end

__END__
diff --git a/cmake/FindGo.cmake b/cmake/FindGo.cmake
index b4f79f4..8667bf4 100644
--- a/cmake/FindGo.cmake
+++ b/cmake/FindGo.cmake
@@ -12,7 +12,7 @@
 #   find_package(Go 1.2 REQUIRED)


-find_program(GO_EXECUTABLE go PATHS ENV GOROOT GOPATH GOBIN PATH_SUFFIXES bin)
+find_program(GO_EXECUTABLE go14 PATHS ENV GOROOT GOPATH GOBIN PATH_SUFFIXES bin)
 if (GO_EXECUTABLE)
     execute_process(COMMAND ${GO_EXECUTABLE} version OUTPUT_VARIABLE GO_VERSION_OUTPUT OUTPUT_STRIP_TRAILING_WHITESPACE)
     if(GO_VERSION_OUTPUT MATCHES "go([0-9]+\\.[0-9]+\\.?[0-9]*)[a-zA-Z0-9]* ([^/]+)/(.*)")
