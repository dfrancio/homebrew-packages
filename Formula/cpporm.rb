class Cpporm < Formula
  desc "Simple ORM library with SQL parser"
  homepage "https://github.com/dsogari/cpporm"
  url "https://github.com/dsogari/cpporm/archive/v0.2.20.tar.gz"
  sha256 "b77c28902fcbffa37b31905db4a42625d7f68abfbde156bace2d6a2935b1fa4c"
  head "https://github.com/dsogari/cpporm.git"

  depends_on "cmake" => :build
  depends_on "boost" => :run
  depends_on "gflags" => :run
  depends_on "antlr4-runtime-cpp" => :run
  depends_on "dsogari/packages/soci" => "with-sqlite"

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
