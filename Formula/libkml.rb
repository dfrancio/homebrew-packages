class Libkml < Formula
  desc "Reference implementation of OGC KML 2.2"
  homepage "https://github.com/google/libkml"
  url "https://github.com/libkml/libkml/archive/1.3.0.tar.gz"
  sha256 "8892439e5570091965aaffe30b08631fdf7ca7f81f6495b4648f0950d7ea7963"
  head "https://github.com/libkml/libkml.git"

  bottle do
    cellar :any
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "1c2a9f82ef885e24af995a3e166525f42d2cabf00271f3938b31fa1834161b6d" => :sierra
  end

  depends_on :python => :recommended
  depends_on "cmake" => :build
  depends_on "boost" => :run
  depends_on "uriparser" => :run
  depends_on "minizip" => :run
  depends_on "swig" => :build if build.with?("python")

  def install
    inreplace "./src/swig/CMakeLists.txt" do |s|
      s.gsub! /\${PYTHON_INSTALL_DIR}/, "lib/python2.7/site-packages/libkml"
      s.gsub! /(.*swig_add_module.*python.*)/, "\\1\n    SET_TARGET_PROPERTIES(${SWIG_MODULE_${MODULE_NAME}_REAL_NAME} PROPERTIES LINK_FLAGS \"-undefined dynamic_lookup\")"
      s.gsub! /\${PYTHON_LIBRARIES}/, ""
    end

    args = std_cmake_args
    if build.with? "python"
      args << "-DWITH_SWIG:BOOL=ON"
      args << "-DWITH_PYTHON:BOOL=ON"
    end

    system "cmake", ".", *args
    system "make"
    system "make", "install"

    (lib/"python2.7/site-packages/libkml.pth").write <<-EOS.undent
      # .pth file for the libkml extensions
      libkml
    EOS
  end

  test do
    system "make", "check"

    (testpath/"test.cpp").write <<-EOS.undent
      #include <libkml.h>
      int main() {
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-llibkml", "-o", "test"
    system "./test"
  end
end
