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
    end

    def set_github_token
      creds_filepath = "/opt/dev/var/private/git_credential_store"

      unless File.file?(creds_filepath)
        raise CurlDownloadStrategyError, "No github auth credentials found. Please run `dev github auth`."
      end

      file = File.open(creds_filepath)
      contents = file.read.strip!
      creds = URI.parse(contents)

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

  @@version = "0.3.0"

  desc 'Manage mTLS certificates for Conductor and Trino'
  homepage 'https://github.com/Shopify/certloader'
  version @@version
  plist_options manual: "export GIN_MODE=release && #{HOMEBREW_PREFIX}/opt/trino-certloader/bin/trino-certloader"

  case
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "6efac95333b08c10cf0ac23f18c17060440d8712d37ea92dd33b5e9a0a08de39"
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Shopify/certloader/releases/download/#{@@version}/certloader_darwin_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "67d799667be86e9bdf297376f0f32319fd4109be095a6803dcb46b6b2b233c7f"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install({"certloader" => "trino-certloader"})
    mkdir_p var/"log/trino-certloader"
    mkdir_p var/"trino-certloader/certs"
  end

  def plist
    home = Dir.home
    <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>EnvironmentVariables</key>
      <dict>
       <key>GIN_MODE</key>
       <string>release</string>
      </dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/trino-certloader</string>
        <string>-o=#{var}/trino-certloader/certs</string>
        <string>--no-tracing</string>
        <string>--log-metrics</string>
        <string>--combined-pem</string>
        <string>-vault.pki.path=certify/conductor/production</string>
        <string>-vault.auth.type=github</string>
        <string>-vault.auth.github.token.path=/opt/dev/var/private/git_credential_store</string>
        <string>-sync.interval=10s</string>
        <string>-cert.duration=12h</string>
        <string>-cert.renew-before=11h59m</string>
        <string>-admin-addr=:5201</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>#{var}/log/trino-certloader/trino-certloader_err.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/trino-certloader/trino-certloader.log</string>
    </dict>
    </plist>
    EOS
  end
  test do
    system "#{bin}/certloader", "--help"
  end
end
