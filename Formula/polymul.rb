class Polymul < Formula
  desc "Multivariate polynomial multiplication with C++ templates"
  homepage "https://github.com/dsogari/polymul"
  url "https://github.com/dsogari/polymul/archive/v0.1.0.tar.gz"
  sha256 "fd90d76df1e108bffedf4a909d6212bc86c100c468cdd74db6fd3423041480e9"
  head "https://github.com/dsogari/polymul.git"

  bottle do
    cellar :any_skip_relocation
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "53c515d4f271cf95aa074b79fe6b92ec5efbcec30f864eac41f5cbccca638c96" => :sierra
  end

  depends_on :xcode => :build

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make"
    system "make", "install"
  end
end
