class DockerSshAgentForward < Formula
  desc "Forward SSH agent socket into a container"
  homepage "https://github.com/avsm/docker-ssh-agent-forward"
  head "https://github.com/avsm/docker-ssh-agent-forward.git"
  url "https://github.com/avsm/docker-ssh-agent-forward/archive/master.tar.gz"
  sha256 "3f6b11c72fe26a7228074d453bf13c54d03be09a11a7e8f1277c6ec9a411ecda"

  def install
    ENV['PATH']   = "#{ENV['PATH']}:/usr/local/bin"
    ENV['PREFIX'] = prefix

    system "make", "install"
  end
end
