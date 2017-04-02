class Gdal < Formula
  desc "Geospatial Data Abstraction Library"
  homepage "http://www.gdal.org"
  url "https://github.com/dsogari/gdal/archive/v2.1.4.tar.gz"
  sha256 "050af48e000eb8181a41d57ec5e11de2a4e774121408feb43b53a94b06c5b8ee"
  head "https://github.com/dsogari/gdal.git"
  
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
    inreplace "frmts/jpeg2000/jpeg2000_vsil_io.cpp", "uchar", "u_char"

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
end
