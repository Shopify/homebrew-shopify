class DockerSshAgentForward < Formula
  desc "Forward SSH agent socket into a container"
  homepage "https://github.com/Shopify/docker-ssh-agent-forward"
  head "https://github.com/Shopify/docker-ssh-agent-forward.git"
  url "https://github.com/Shopify/docker-ssh-agent-forward/archive/1.0.tar.gz"
  sha256 "75d111b84cffbb6caed6a555cf88263a8079b609d2d0bb484afefdbb01f91251"

  def install
    ENV['PATH']   = "#{ENV['PATH']}:/usr/local/bin"
    ENV['PREFIX'] = prefix

    system "make", "install"
  end
end
