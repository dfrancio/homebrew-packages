class CefPdf < Formula
  desc "HTML to PDF utility based on CEF"
  homepage "https://github.com/spajak/cef-pdf"
  url "https://github.com/dsogari/cef-pdf/archive/v0.3.0.tar.gz"
  sha256 "79279128bbf21a1cb6b136fde5de8545c05f4550acc10fd568c1654f26ceba4e"
  head "https://github.com/dsogari/cef-pdf.git"

  depends_on "cmake" => :build
  depends_on "dsogari/packages/cef" => :build

  def install
    cef_root = Formula["dsogari/packages/cef"].opt_prefix
    system "cmake", ".", *std_cmake_args,
      "-DBUILD_SHARED_LIBS=ON",
      "-DCEF_ROOT=#{cef_root}"
    system "make"

    prefix.install "src/Release/cef-pdf.app"
  end
end
