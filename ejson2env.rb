class Ejson2env < Formula
  desc 'Ejson2env is a utility to export decrypted ejson secrets as environment variable assignments'
  homepage 'https://github.com/Shopify/ejson2env'
  # use built binaries from goreleaser. get sha256 from <versiondetails>-checksums.txt
  url 'https://github.com/Shopify/ejson2env/releases/download/v2.0.8/ejson2env_2.0.8_darwin_all.tar.gz'
  sha256 '98734569cde6075bb5cf43a2aa83ebec2ad91959a43eb077538fd8feda850af7'

  def install
    bin.install 'ejson2env'
  end
end
