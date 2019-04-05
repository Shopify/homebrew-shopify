class SwiftDocker < Formula
    desc "Test your swift packages with one command `swift docker test`"
    homepage ""
    url "https://github.com/iainsmith/swift-docker/archive/0.1.1.tar.gz"
    sha256 "9a982459ccd894490d676073a9908bfbad9d49008d565337cfe76cc925704402"
    depends_on :xcode => :build
  
    def install
        system "swift", "build", "--disable-sandbox", "-c", "release"
        bin.install ".build/release/swift-docker"
    end
  
    test do
        system "swift", "package", "init", "--type", "library"
        system "swift docker test"
    end
end
