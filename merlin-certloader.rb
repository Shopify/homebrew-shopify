class MerlinCertloader < Formula
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
      @url = download_url
    end

    def set_github_token
      creds_filepath = "/opt/dev/var/private/git_credential_store"

      unless File.file?(creds_filepath)
        raise CurlDownloadStrategyError, "No github auth credentials found. Please run `dev github auth`."
      end

      file = File.open(creds_filepath)
      contents = file.read.strip!.split("\n")
      latest_raw_creds = contents.reverse.find{|credential| credential.strip.end_with?("@github.com")}
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

  @@version = "0.4.3"

  desc 'Manage mTLS certificates for Merlin'
  homepage 'https://github.com/Shopify/certloader'
  version @@version

  case
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "9dcedf01559c30e121070f1c6ec4858546de1d7844826c37e1370514e7193c80"
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "a1d7d173c68f367d82bea395c5afe9af8563f8b087f02bab30f2c9f928ade85f"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({"certloader" => "merlin-certloader"})
    mkdir_p var/"log/merlin-certloader"
    mkdir_p var/"merlin-certloader/certs"
  end

  service do
    run [
        bin/"merlin-certloader",
        "-o=#{var}/merlin-certloader/certs",
        "--admin-addr=:5092",
        "--no-tracing",
        "--log-metrics",
        "--combined-pem",
        "-vault.pki.path=certify/merlin/staging/adhoc",
        "-vault.auth.type=github",
        "-vault.auth.github.token.path=/opt/dev/var/private/git_credential_store",
        "-sync.interval=10s",
        "-cert.duration=12h",
        "-cert.renew-before=11h59m",
    ]
    environment_variables GIN_MODE: "release"
    log_path var/"log/merlin-certloader/merlin-certloader_err.log"
    error_log_path var/"log/merlin-certloader/merlin-certloader.log"
  end

  test do
    system "#{bin}/certloader", "--help"
  end
end
