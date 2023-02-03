class Certloader < Formula
  # GitHubPrivateRepositoryReleaseDownloadStrategy downloads tarballs from GitHub
  # Release assets. To use it, add
  # `using: GitHubPrivateRepositoryReleaseDownloadStrategy` to the URL section of
  # your formula. This download strategy uses GitHub access tokens from `dev github print-auth`
  # to sign the request.
  class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
    require "utils/formatter"
    require "utils/github"

    def initialize(url, name, version, **meta)
      super
      set_github_token
      parse_url_pattern
    end

    def set_github_token
      creds_filepath = "/opt/dev/var/private/git_credential_store"

      unless File.file?(creds_filepath)
        raise CurlDownloadStrategyError, "No github auth credentials found. Please run `dev github auth`."
      end

      file = File.open(creds_filepath)
      contents = file.read.strip!.split("\n")
      latest_raw_creds = contents.last
      creds = URI.parse(latest_raw_creds)

      @github_token = creds.password

      unless @github_token
        raise CurlDownloadStrategyError, "No github auth found. Please run `dev github auth`."
      end
    end

    def parse_url_pattern
      unless match = url.match(%r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)})
        raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
      end

      _, @owner, @repo, @tag, @filename = *match
    end

    def download_url
      "https://#{@github_token}@api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
    end

    private

    def _fetch(url:, resolved_url:, timeout:)
      # HTTP request header `Accept: application/octet-stream` is required.
      # Without this, the GitHub API will respond with metadata, not binary.
      curl_download download_url, "--header", "Accept: application/octet-stream", to: temporary_path
    end

    def asset_id
      @asset_id ||= resolve_asset_id
    end

    def resolve_asset_id
      release_metadata = fetch_release_metadata
      assets = release_metadata["assets"].select { |a| a["name"] == @filename }
      raise CurlDownloadStrategyError, "Asset file not found." if assets.empty?

      assets.first["id"]
    end

    def fetch_release_metadata
      release_url = "https://#{@github_token}@api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
      GitHub::API.open_rest(release_url)
    end
  end

  @@version = "0.3.2"

  desc 'CLI for managing certificates'
  homepage 'https://github.com/Shopify/certloader'
  version @@version

  case
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "7eb27a38551073a2b58b9b7dc39469e043e02e947ce73e2cc242435ab794ba3f"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({"certloader" => "certloader"})
    mkdir_p var/"log/certloader"
    mkdir_p var/"certloader/certs"
  end

  test do
    system "#{bin}/certloader", "--help"
  end
end
