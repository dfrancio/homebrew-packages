class Cpporm < Formula
  desc "Simple ORM library with SQL parser"
  homepage "https://github.com/dsogari/cpporm"
  url "https://github.com/dsogari/cpporm/archive/v0.2.16.tar.gz"
  sha256 "81fdcd06d2305879c080e44dcaf681bbdebcf31e0facb924a42c0f12c948eedd"
  head "https://github.com/dsogari/cpporm.git"

  bottle do
    cellar :any
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "ac22f70a2af52a751b1645fe1d0a1a84d71518f3b17704d1e618a3e6cf4e8e74" => :sierra
  end

  depends_on "cmake" => :build
  depends_on "boost" => :run
  depends_on "gflags" => :run
  depends_on "soci" => :run
  depends_on "antlr4-runtime-cpp" => :run

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <cpporm.h>
      int main() {
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lcpporm", "-o", "test"
    system "./test"
  end
end
