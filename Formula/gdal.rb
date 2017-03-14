class Gdal < Formula
  desc "Geospatial Data Abstraction Library"
  homepage "http://www.gdal.org"
  url "https://github.com/dsogari/gdal/archive/v2.1.3.tar.gz"
  sha256 "0aa6348515874bd8f3f1f1288fc6115a190d09ad837033fd2b828bab97e32e92"
  head "https://github.com/dsogari/gdal.git"
  
  bottle do
    root_url "https://github.com/dsogari/homebrew-packages/raw/master/Bottle"
    sha256 "e9c7d5ff4fd8dd6de9700c5cc36ff47514b03623d402722baaa901ecab2ba8e7" => :sierra
  end

  depends_on :xcode => :build
  depends_on "freexl" => :run
  depends_on "geos" => :run
  depends_on "giflib" => :run
  depends_on "jpeg" => :run
  depends_on "jasper" => :run
  depends_on "json-c" => :run
  depends_on "libgeotiff" => :run
  depends_on "libpng" => :run
  depends_on "libspatialite" => :run
  depends_on "libtiff" => :run
  depends_on "libxml2" => :run
  depends_on "openjpeg" => :run
  depends_on "pcre" => :run
  depends_on "podofo" => :run
  depends_on "poppler" => :run
  depends_on "qhull" => :run
  depends_on "sqlite" => :run
  depends_on "unixodbc" => :run
  depends_on "webp" => :run
  depends_on "xerces-c" => :run
  depends_on "xz" => :run
  depends_on "homebrew/science/armadillo" => :run
  depends_on "homebrew/science/cfitsio" => :run
  depends_on "homebrew/science/netcdf" => :run
  depends_on "dsogari/packages/libkml" => :run

  def install
    cd "gdal"
    inreplace "frmts/jpeg2000/jpeg2000_vsil_io.cpp",
       "stream->bufbase_ = JAS_CAST(uchar *, buf);",
       "stream->bufbase_ = JAS_CAST(u_char *, buf);"

    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--with-local=#{HOMEBREW_PREFIX}",
                          "--with-armadillo=yes",
                          "--with-liblzma=yes",
                          "--with-sqlite3=yes",
                          "--with-spatialite=yes",
                          "--with-xerces=#{HOMEBREW_PREFIX}",
                          "--with-libkml=#{HOMEBREW_PREFIX}",
                          "--with-poppler=#{HOMEBREW_PREFIX}",
                          "--with-podofo=#{HOMEBREW_PREFIX}",
                          "--with-expat=/usr"
    system "make"
    system "make", "install"
  end

  test do
    # basic tests to see if third-party dylibs are loading OK
    system "#{bin}/gdalinfo", "--formats"
    system "#{bin}/ogrinfo", "--formats"
  end
end
