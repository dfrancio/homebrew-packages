class Qtwebkit < Formula
  desc "Open Source Web Browser Engine - Qt"
  homepage "https://webkit.org"
  url "https://github.com/annulen/webkit/releases/download/qtwebkit-tp5/qtwebkit-tp5.tar.xz"
  version "5.602.3"
  sha256 "553dfb47a10d256314b74105d0eafadab0efc0ebd32d77a09cffbe2fed09def8"
  head "https://github.com/annulen/webkit.git"

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

  test do
    (testpath/"hello.pro").write <<-EOS.undent
      QT       += core qtwebkit qtwebkitwidgets
      QT       -= gui
      TARGET    = hello
      CONFIG   += console
      CONFIG   -= app_bundle
      TEMPLATE  = app
      SOURCES  += main.cpp
    EOS

    (testpath/"main.cpp").write <<-EOS.undent
      #include <QCoreApplication>
      #include <QDebug>
      #include <QWebKit>
      int main(int argc, char *argv[])
      {
        QCoreApplication a(argc, argv);
        qDebug() << "Hello World!";
        return 0;
      }
    EOS

    system bin/"qmake", testpath/"hello.pro"
    system "make"
    assert File.exist?("hello")
    assert File.exist?("main.o")
    system "./hello"
  end
end
