class DockerSshAgentForward < Formula
  desc "Forward SSH agent socket into a container"
  homepage "https://github.com/avsm/docker-ssh-agent-forward"
  head "https://github.com/avsm/docker-ssh-agent-forward.git"

  def install
    ENV['PATH']   = "#{ENV['PATH']}:/usr/local/bin"
    ENV['PREFIX'] = prefix

    system "make"
    system "make", "install"
  end
end
