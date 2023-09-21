class TrinoCertloader < Formula
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

  @@version = "0.7.7"

  desc 'Manage mTLS certificates for Conductor and Trino'
  homepage 'https://github.com/Shopify/certloader'
  version @@version

  case
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "d8045f6cec20b0055c58aedca7f22247187c321e16b861dad93bd06390c5d529"
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "3da0cbde1b540a23af2d807e259317f77dc859882cd8e0f7d7fa5be25d0aff47"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({"certloader" => "trino-certloader"})
    mkdir_p var/"log/trino-certloader"
    mkdir_p var/"trino-certloader/certs"
  end

  service do
    run [
      bin/"trino-certloader",
      "-o=#{var}/trino-certloader/certs",
      "--no-tracing",
      "--log-metrics",
      "--combined-pem",
      "-googleca.ca-pool=trino-conductor-root",
      "-googleca.issuing-ca-id=trino-conductor-root",
      "-googleca.location=us-central1",
      "-googleca.key-algorithm=RSA",
      "-googleca.project=shopify-certificate-authority",
      "-cert.duration=24h",
      "-admin-addr=:5201",
    ]
    environment_variables GIN_MODE: "release"
    log_path var/"log/trino-certloader/trino-certloader_err.log"
    error_log_path var/"log/trino-certloader/trino-certloader.log"
  end

  test do
    system "#{bin}/certloader", "--help"
  end
end
