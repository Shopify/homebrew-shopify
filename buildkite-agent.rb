class BuildkiteAgent < Formula
  desc "Build runner for use with Buildkite"
  homepage "https://buildkite.com/docs/agent"

  stable do
    version "3.12.0"
    url     "https://github.com/buildkite/agent/releases/download/v3.12.0/buildkite-agent-darwin-amd64-3.12.0.tar.gz"
    sha256  "c3e26dcfb729b7112761d4e6c1ac037f43ce5918c624427a817ded790fe769c7"
  end

  devel do
    version "3.0-beta.44"
    url     "https://github.com/buildkite/agent/releases/download/v3.0-beta.44/buildkite-agent-darwin-amd64-3.0-beta.44.tar.gz"
    sha256  "fe53562074dc40683f89f7429e1a256c9a891615b63ec1238d13ba6d0eed7d96"
  end

  option "token=", "Your account's agent token to add to the config on install"

  def default_agent_token
    "xxx"
  end

  def agent_token
    ARGV.value("token") || default_agent_token
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
      agent_config_path.write(default_config_file(agent_token))
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

  plist_options :manual => "buildkite-agent start"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}/bin</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{HOMEBREW_PREFIX}/bin/buildkite-agent</string>
          <string>start</string>
          <string>--config</string>
          <string>#{agent_config_path}</string>
          <!--<string>--debug</string>-->
        </array>
        <key>EnvironmentVariables</key>
        <dict>
          <key>PATH</key>
          <string>#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
        </dict>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>ProcessType</key>
        <string>Interactive</string>
        <key>ThrottleInterval</key>
        <integer>30</integer>
        <key>StandardOutPath</key>
        <string>#{var}/log/buildkite-agent.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/buildkite-agent.log</string>
      </dict>
      </plist>
    EOS
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