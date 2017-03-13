class Soci < Formula
  desc "The C++ Database Access Library"
  homepage "http://soci.sourceforge.net"
  head "https://github.com/SOCI/soci.git",
    :revision => "e719c44bb89949d3c179a6390de57ccd9046878b"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "sqlite" => :build
  depends_on "unixodbc" => :build
  depends_on "postgresql" => :build
  depends_on "mariadb-connector-c" => :build

  def install
    inreplace "./cmake/SociConfig.cmake" do |s|
      s.gsub! /-pedantic -Werror/, ""
      s.gsub! /-Wredundant-decls/, ""
    end
    inreplace "./src/core/CMakeLists.txt", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"
    inreplace "./cmake/SociBackend.cmake", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"

    args = %W[
      -DSOCI_TESTS=OFF
      -DSQLITE3_INCLUDE_DIR=/usr/local/opt/sqlite3/include
      -DSQLITE3_LIBRARIES=/usr/local/opt/sqlite3/lib/libsqlite3.dylib
      -DODBC_INCLUDE_DIR=/usr/local/include
      -DODBC_LIBRARIES=/usr/local/lib/libodbc.dylib
      -DPostgreSQL_INCLUDE_DIR=/usr/local/include
      -DPostgreSQL_LIBRARIES=/usr/local/lib/libpq.dylib
      -DMYSQL_INCLUDE_DIR=/usr/local/include/mariadb
      -DMYSQL_LIBRARIES=/usr/local/lib/mariadb/libmysqlclient.dylib
    ]

    system "cmake", ".", *std_cmake_args, *args
    system "make"
    system "make", "install"
  end
end
