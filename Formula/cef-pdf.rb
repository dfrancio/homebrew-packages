class CefPdf < Formula
  desc "HTML to PDF utility based on CEF"
  homepage "https://github.com/spajak/cef-pdf"
  url "https://github.com/spajak/cef-pdf/archive/v0.2.1.tar.gz"
  sha256 "2663e45c67dd81f1f9243a12489b177a5cee8fa6f1dd33345088173a5d02f2fe"
  head "https://github.com/spajak/cef-pdf.git"

  keg_only "Intended for development of CEF-based applications. Do not 'brew link' this software!"

  depends_on "cmake" => :build
  depends_on "cef" => :build

  def install
    
  end
end
