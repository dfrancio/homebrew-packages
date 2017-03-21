class Cef < Formula
  desc "Chromium Embedded Framework (QtWebKit)"
  homepage "https://bitbucket.org/chromiumembedded/cef"
  url "http://opensource.spotify.com/cefbuilds/cef_binary_3.2924.1575.g97389a9_macosx64.tar.bz2"
  version "3.2924.1575.g97389a9"
  sha256 "0aadaa47c10119195e782cf138de4c3e05a717c5f3e32e78004020e7b428c062"
  head "https://bitbucket.org/chromiumembedded/cef.git"

  depends_on "cmake" => :build

  keg_only "Intended for development of CEF-based applications. Do not 'brew link' this software!"

  def install
    prefix.install Dir["*"]
  end
end
