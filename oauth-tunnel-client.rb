class OauthTunnelClient < Formula
  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url "https://storage.googleapis.com/artifacts.data-148903.appspot.com/containers/repositories/library/apps/development/oauth-tunnel-client/oauth-tunnel-client.tar.gz"
  sha256 "b90f0a43237e9176d1e37af1ff26041bee714aa6f55a7857f0f3c4df1ced9acc"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/Shopify/oauth-tunnel-client").install buildpath.children
    cd "src/github.com/Shopify/oauth-tunnel-client" do
      system "go", "build", "-o", bin/"oauth-tunnel-client"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test oauth`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
