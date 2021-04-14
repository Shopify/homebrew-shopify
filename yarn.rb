require "language/node"

class Yarn < Formula
  desc "JavaScript package manager"
  homepage "https://yarnpkg.com/"
  url "https://yarnpkg.com/downloads/0.27.5/yarn-v0.27.5.tar.gz"
  sha256 "f0f3510246ee74eb660ea06930dcded7b684eac2593aa979a7add84b72517968"
  head "https://github.com/yarnpkg/yarn.git"

  bottle do
    root_url "https://burkelibbey.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, sierra: "b43c66a5cc378712dc9871bcc31abb78ad1f9790a9b1226109bc1c2f98d1e626"
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "6061af0e52d8bdf82af1dcc65c17d879130eab0100275b89f3c416105a484a44" => :catalina
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
