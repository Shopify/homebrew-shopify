class VoucherClient < Formula
  desc "Voucher Client is a tool for connecting to a running Voucher server."
  homepage "https://github.com/grafeas/voucher"
  version "2.7.0"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/grafeas/voucher/releases/download/v#{version}/voucher_client_#{version}_Darwin_x86_64.tar.gz"
    sha256 "76e374a99a545a0d9fe45fa581766288f52061ed569db8a85174a9aca2d183ba"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/grafeas/voucher/releases/download/v#{version}/voucher_client_#{version}_Darwin_arm64.tar.gz"
    sha256 "a8e184d6820a831c47636d1a7544c012b0fae3d76659aeccdedbf8654b0199e3"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/grafeas/voucher/releases/download/v#{version}/voucher_client_#{version}_Linux_x86_64.tar.gz"
    sha256 "bc95e43ca73c182bf4671ebede8a14ffc85139b654df2f4d72429a39a2ce1352"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/grafeas/voucher/releases/download/v#{version}/voucher_client_#{version}_Linux_arm64.tar.gz"
    sha256 "8254553fb0148eb40fed1bb69285a1a2d9037e8c1079bfcf7b3023b4f361954d"
  else
    odie "Unexpected platform!"
  end

  def install
    bin.install "voucher_client"
  end
end
