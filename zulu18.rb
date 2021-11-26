class Zulu18 < Formula
  desc "OpenJDK distribution from Azul"
  homepage "https://www.azul.com/downloads/"

  jdk_version = "18.0.0-ea.24"
  zulu_version = "18.0.57-ea"
  arch = Hardware::CPU.intel? ? "x64" : "aarch64"
  choice = Hardware::CPU.intel? ? "x86" : "arm"

  version jdk_version


  url "https://cdn.azul.com/zulu/bin/zulu#{zulu_version}-jdk#{jdk_version}-macosx_#{arch}.zip"

  if choice == "x86"
    sha256 "39c23971676d1e24cc0d9d1aab6dc0c9f0545e19fdb8e8a3462efb987fa6fdf3"
  else
    sha256 "ce4e463007492292a732a264d6588711e7ba6209263019bafe02745f8e78a9e8"
  end

  def install 
    bin.install Dir["bin/*"] 
    include.install Dir["include/*"] 
    lib.install Dir["lib/*"] 
    rm lib + "libfreetype.dylib"
    man.install Dir["man/*"] 
  end
  def test 
    system "bin/java", "-version"
  end
end
