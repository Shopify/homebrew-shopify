require "language/node"

class Yarn < Formula
  desc "Javascript package manager"
  homepage "https://yarnpkg.com/"
  url "https://yarnpkg.com/downloads/0.16.1/yarn-v0.16.1.tar.gz"
  sha256 "73be27c34ef1dd4217fec23cdfb6b800cd995e9079d4c4764724ef98e98fec07"
  head "https://github.com/yarnpkg/yarn.git"

  bottle do
    root_url "https://s3.amazonaws.com/burkelibbey"
    cellar :any_skip_relocation
    rebuild 2
    sha256 "58b3c862a1774bcf134e5d76681cd31ab49f75426998c500412e36210e6ac488" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"yarn", "add", "jquery"
  end
end
