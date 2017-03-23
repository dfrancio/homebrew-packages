class CefPdf < Formula
  desc "HTML to PDF utility based on CEF"
  homepage "https://github.com/spajak/cef-pdf"
  url "https://github.com/dsogari/cef-pdf/archive/v0.3.0.tar.gz"
  sha256 "c56c6fab59586837cab39e72731701b6a1b7256925eca52b77071c3c802597a0"
  head "https://github.com/dsogari/cef-pdf.git"

  depends_on "cmake" => :build
  depends_on "dsogari/packages/cef" => :build
  depends_on "boost" => :run

  def install
    cef_root = Formula["dsogari/packages/cef"].opt_prefix
    system "cmake", ".", *std_cmake_args,
      "-DBUILD_SHARED_LIBS=ON",
      "-DCEF_ROOT=#{cef_root}"
    system "make"

    prefix.install "src/Release/cef-pdf.app"
  end
end
