class Breakpad < Formula
  desc "Client and server components which implement a crash-reporting system"
  homepage "https://chromium.googlesource.com/breakpad/breakpad/"
  head "https://chromium.googlesource.com/breakpad/breakpad.git",
      :revision => "7ec3caf6c7cdff0a99cd34249acfdc61f76f2d86"

  depends_on :xcode => :build

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make"
    system "make", "install"
  end
end
