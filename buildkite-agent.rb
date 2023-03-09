class BuildkiteAgent < Formula
  desc "Build runner for use with Buildkite"
  homepage "https://buildkite.com/docs/agent"

  stable do
    version "3.33.3"
    if Hardware::CPU.arm?
      url     "https://github.com/buildkite/agent/releases/download/v3.33.3/buildkite-agent-darwin-arm64-3.33.3.tar.gz"
      sha256  "1f7ad047f264750fb4b98e9cb7a439a768496358b544641da904913800d035c8"
    else
      url     "https://github.com/buildkite/agent/releases/download/v3.33.3/buildkite-agent-darwin-amd64-3.33.3.tar.gz"
      sha256  "19f108798308a98dcdddb750faea1f8fa8dc832501fa46757ca4b462b9eb58a0"
    end
  end

  def default_agent_token
    "xxx"
  end

  def agent_etc
    etc/"buildkite-agent"
  end

  def agent_var
    var/"buildkite-agent"
  end

  def agent_hooks_path
    agent_etc/"hooks"
  end

  def agent_builds_path
    agent_var/"builds"
  end

  def agent_plugins_path
    agent_var/"plugins"
  end

  def agent_bootstrap_path
    if stable?
      agent_etc/"bootstrap.sh"
    else
      opt_bin/"buildkite-agent bootstrap"
    end
  end

  def agent_config_path
    agent_etc/"buildkite-agent.cfg"
  end

  def agent_config_dist_path
    pkgshare/"buildkite-agent.dist.cfg"
  end

  def install
    agent_etc.mkpath
    agent_var.mkpath
    pkgshare.mkpath
    agent_hooks_path.mkpath
    agent_builds_path.mkpath

    agent_hooks_path.install Dir["hooks/*"]
    if stable?
      agent_etc.install "bootstrap.sh"
    end

    agent_config_dist_path.write(default_config_file)

    if agent_config_path.exist?
      puts "\033[35mIgnoring existing config file at #{agent_config_path}\033[0m"
      puts "\033[35mFor changes see the updated dist copy at #{agent_config_dist_path}\033[0m"
    else
      agent_config_path.write(default_config_file)
    end

    bin.install "buildkite-agent"
  end

  def default_config_file(agent_token = default_agent_token)
    File.read("buildkite-agent.cfg")
        .gsub(/token=.+/, "token=\"#{agent_token}\"")
        .gsub(/bootstrap-script=.+/, "bootstrap-script=\"#{agent_bootstrap_path}\"")
        .gsub(/build-path=.+/, "build-path=\"#{agent_builds_path}\"")
        .gsub(/hooks-path=.+/, "hooks-path=\"#{agent_hooks_path}\"")
        .gsub(/plugins-path=.+/, "plugins-path=\"#{agent_plugins_path}\"")
  end

  def caveats
    <<~EOS
      \033[32mbuildkite-agent is now installed!\033[0m#{agent_token_reminder}

      Configuration file (to configure agent meta-data, priority, name, etc):
          #{agent_config_path}

      Hooks directory (for customising the agent):
          #{agent_hooks_path}

      Builds directory:
          #{agent_builds_path}

      Log paths:
          #{var}/log/buildkite-agent.log
          #{var}/log/buildkite-agent.error.log

      If you set up the LaunchAgent, set your machine to auto-login as
      your current user. It's also recommended to install Caffeine
      (http://lightheadsw.com/caffeine/) to prevent your machine from going to
      sleep or logging out.

      To run multiple agents simply run the buildkite-agent start command
      multiple times, or duplicate the LaunchAgent plist to create another
      that starts on login.
    EOS
  end

  service do
    run [opt_bin/"buildkite-agent", "start", "--config", f.agent_config_path]
    process_type :interactive
    working_dir HOMEBREW_PREFIX
    environment_variables PATH: std_service_path_env
    keep_alive successful_exit: false
    log_path var/"log/buildkite-agent.log"
    error_log_path var/"log/buildkite-agent.log"
  end

  def agent_token_reminder
    return "" unless agent_config_path.exist?

    if agent_config_path.read.include?(default_agent_token)
      "\n      \n      \033[31mDon't forget to update your configuration file with your agent token\033[0m"
    end
  end

  test do
    system "#{bin}/buildkite-agent", "--help"
  end
end
