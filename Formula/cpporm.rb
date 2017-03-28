class Cpporm < Formula
  desc "Simple ORM library with SQL parser"
  homepage "https://github.com/dsogari/cpporm"
  url "https://github.com/dsogari/cpporm/archive/v0.2.19.tar.gz"
  sha256 "7d019b77d4155c8ba7149009a93549b9c8b2245a168a2272988c57c3ff850a5c"
  head "https://github.com/dsogari/cpporm.git"

  bottle do
    cellar :any
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "aa6398225e4e34e16edd96df2250c001f45af7ef0b14eb5f4fa4b717ff26ab6a" => :sierra
  end

  depends_on "cmake" => :build
  depends_on "boost" => :run
  depends_on "gflags" => :run
  depends_on "antlr4-runtime-cpp" => :run
  depends_on "dsogari/packages/soci" => :run

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "make"
    system "make", "install"
  end
end
