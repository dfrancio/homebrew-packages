class Qtwebkit < Formula
  desc "Open Source Web Browser Engine - Qt"
  homepage "https://webkit.org"
  url "https://github.com/annulen/webkit/releases/download/qtwebkit-tp5/qtwebkit-tp5.tar.xz"
  version "5.602.3"
  sha256 "553dfb47a10d256314b74105d0eafadab0efc0ebd32d77a09cffbe2fed09def8"
  head "https://github.com/annulen/webkit.git"

  bottle do
    cellar :any
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "fec628b377eaf4875e9829ff59aea142ff779e616180b8e6c8428b4c9f24f25a" => :sierra
  end

  keg_only "Same as Qt 5"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qt5" => :run
  depends_on "jpeg" => :run
  depends_on "libpng" => :run
  depends_on "webp" => :recommended
  depends_on "fontconfig" => :recommended

  def install
    args = std_cmake_args + %w[
      -DCMAKE_PREFIX_PATH=#{HOMEBREW_PREFIX}
      -DPORT=Qt
    ]
    system "cmake", ".", *args
    system "make"
    system "make", "install"
  end

  def postinstall
    ohai "hello"
    # qt5_modules = Formula["qt5"].opt_prefix/"mkspecs/modules"
    # qt5_modules.install Dir["#{opt_prefix}/mkspecs/modules/*"]

    # %w[webkit webkitwidgets].each do |a|
    #   inreplace qt5_modules/"qt_lib_#{a}.pri" do |s|
    #     s.gsub! /(.*module_config.*)/, "\\1lib_bundle"
    #     s.gsub! /(.*rpath = (.*))/, "\\1\nQMAKE_RPATHDIR *= \\2"
    #   end
    # end
  end
end
