class LuajitShopify < Formula
  desc "Just-In-Time Compiler (JIT) for the Lua programming language"
  homepage "http://luajit.org/luajit.html"
  url "http://luajit.org/download/LuaJIT-2.1.0-beta2.tar.gz"
  sha256 "713924ca034b9d99c84a0b7b701794c359ffb54f8e3aa2b84fad52d98384cf47"
  head "http://luajit.org/git/luajit-2.0.git"

  bottle do
    root_url "http://burkelibbey.s3.amazonaws.com"
    rebuild 1
    sha256 "614270751ee3379f1aa931accefc6d29d0b97b3bdf19e1ef550bb8b32e0d7954" => :sierra
  end

  conflicts_with "luajit", :because => "shopify uses luajit 2.1. `brew uninstall luajit` first"

  # https://github.com/LuaJIT/LuaJIT/issues/180
  patch do
    url "https://github.com/LuaJIT/LuaJIT/commit/5837c2a2fb1ba6651.diff"
    sha256 "622ee354f58d2bde2adbfdf432d4f276ddc83a3b5d11b6cab06fb89f381cfcb3"
  end

  deprecated_option "enable-debug" => "with-debug"

  option "with-debug", "Build with debugging symbols"
  option "with-52compat", "Build with additional Lua 5.2 compatibility"

  def install
    # 1 - Override the hardcoded gcc.
    # 2 - Remove the "-march=i686" so we can set the march in cflags.
    # Both changes should persist and were discussed upstream.
    inreplace "src/Makefile" do |f|
      f.change_make_var! "CC", ENV.cc
      f.change_make_var! "CCOPT_x86", ""
    end

    ENV.O2 # Respect the developer's choice.

    args = %W[PREFIX=#{prefix}]
    args << "XCFLAGS=-DLUAJIT_ENABLE_LUA52COMPAT" if build.with? "52compat"

    # This doesn't yet work under superenv because it removes "-g"
    args << "CCDEBUG=-g" if build.with? "debug"

    # The development branch of LuaJIT normally does not install "luajit".
    args << "INSTALL_TNAME=luajit"

    system "make", "amalg", *args
    system "make", "install", *args

    # LuaJIT doesn't automatically symlink unversioned libraries:
    # https://github.com/Homebrew/homebrew/issues/45854.
    lib.install_symlink lib/"libluajit-5.1.dylib" => "libluajit.dylib"
    lib.install_symlink lib/"libluajit-5.1.a" => "libluajit.a"

    # Having an empty Lua dir in lib/share can mess with other Homebrew Luas.
    %W[ #{lib}/lua #{share}/lua ].each { |d| rm_rf d }
  end

  test do
    system "#{bin}/luajit", "-e", <<~EOS
      local ffi = require("ffi")
      ffi.cdef("int printf(const char *fmt, ...);")
      ffi.C.printf("Hello %s!\\n", "#{ENV["USER"]}")
    EOS
  end
end
