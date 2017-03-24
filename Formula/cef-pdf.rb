class CefPdf < Formula
  desc "HTML to PDF utility based on CEF"
  homepage "https://github.com/spajak/cef-pdf"
  url "https://github.com/dsogari/cef-pdf/archive/v0.3.0.tar.gz"
  sha256 "ff1b8ee61d574c09ce3774894e92fd5eadf33d87d3c2225ebdeb32cacebc756c"
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
