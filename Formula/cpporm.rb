class Cpporm < Formula
  desc "Simple ORM library with SQL parser"
  homepage "https://github.com/dsogari/cpporm"
  url "https://github.com/dsogari/cpporm/archive/v0.2.17.tar.gz"
  sha256 "e9a75e4f943d56fd23a7fd089cb1606ca6a2ec6f111a5a5209bfcfaa29a1d01f"
  head "https://github.com/dsogari/cpporm.git"

  bottle do
    cellar :any
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "f199ab361984c487b3de2dce0a9c20b0a030a2b146068856257eebd624475ed4" => :sierra
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
