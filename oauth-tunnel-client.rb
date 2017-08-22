class OauthTunnelClient < Formula
  class GoogleStorageDownloadStrategy < CurlDownloadStrategy
    def ext
      Pathname.new(basename_without_params).extname[/[^?]+/]
    end
  end

  desc 'Create a secure local proxy with Shopify GCP services'
  homepage 'https://github.com/Shopify/oauth-tunnel-client'
  url 'https://storage.googleapis.com/artifacts.data-148903.appspot.com/containers/repositories/library/apps/development/oauth-tunnel-client/oauth-tunnel-client-binaries.tar.gz?GoogleAccessId=johnmartin-cloudsql-client@data-148903.iam.gserviceaccount.com&Expires=1534884426&Signature=wlB1%2FHiSokSrbURCY1d4A7O1Kmpeeib4nDQ5oai3ZhnEp00kqLw1FbMmUuXHpkKrpGsZWetD7RvpEb4E%2BejZYTzrqEcxZ9c4S6btyKZq13tdSvUsCJgG9LdvdtNJi5VazO0P%2FSOBAszNdk1bfR2XEE2mxl0NMGXKnIQwEZ1yBry7kWBlqd6WAJgAhRsvOzsxqe3%2FrY0halvuVdvyBsZ7lmx8CUVdHiKS8olnnOqg9ZpQh2zTy39LwbvhbVbrPfB2MVskZymGkYPHOQaF2vl60R%2F6k2W%2BfSgOIVgboUzkw960%2FhuXjZOrfhUq1WKzgRz8mgBs7D%2B%2BKM4AkgJ7SOBu2g%3D%3D', using: GoogleStorageDownloadStrategy
  sha256 "a50448106a52c88c5f51d27cf0969adbe1ee19e37dc5a462442a2abaa49d01d7"
  version "0.1"

  def install
    bin.install({'oauth-tunnel-client_darwin_amd64' => 'oauth-tunnel-client'})
  end

  test do
    system "#{bin}/oauth-tunnel-client_darwin_amd64", "version"
  end
end
