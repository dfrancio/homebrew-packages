class Qtwebkit < Formula
  desc "Client and server components which implement a crash-reporting system"
  homepage "https://webkit.org"
  url "https://github.com/annulen/webkit/releases/download/qtwebkit-tp5/qtwebkit-tp5.tar.xz"
  sha256 "553dfb47a10d256314b74105d0eafadab0efc0ebd32d77a09cffbe2fed09def8"
  head "https://github.com/annulen/webkit.git"

  depends_on "cmake" => :build
  depends_on "qt5" => :run
  depends_on "libjpeg" => :run
  depends_on "libpng" => :run
  depends_on "webp" => :optional
  depends_on "fontconfig" => :optional
  depends_on "pkg-config" => :optional

  def install
    system "cmake", ".", *std_cmake_args, "-DPORT=Qt"
    system "make"
    system "make", "install"
  end
end
