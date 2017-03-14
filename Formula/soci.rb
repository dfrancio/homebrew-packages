class Soci < Formula
  desc "The C++ Database Access Library"
  homepage "https://soci.sourceforge.io/"
  head "https://github.com/SOCI/soci.git",
    :revision => "e719c44bb89949d3c179a6390de57ccd9046878b"

  option "with-odbc", "Builds with ODBC support"
  option "with-mysql", "Builds with MySQL support"

  depends_on "cmake" => :build
  depends_on "boost" => :optional
  depends_on "sqlite" => :optional
  depends_on "postgresql" => :optional
  depends_on "unixodbc" if build.with? "odbc"
  depends_on "mariadb-connector-c" if build.with? "mysql"

  def translate(a)
    a == "sqlite" ? "sqlite3" : a
  end

  def install
    inreplace "./cmake/SociConfig.cmake" do |s|
      s.gsub! /-pedantic -Werror/, ""
      s.gsub! /-Wredundant-decls/, ""
    end
    inreplace "./src/core/CMakeLists.txt", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"
    inreplace "./cmake/SociBackend.cmake", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"

    args = std_cmake_args + %w[-DSOCI_TESTS=OFF]

    %w[boost sqlite postgresql odbc mysql].each do |a|
      bool = build.with?(a) ? "ON" : "OFF"
      args << "-DWITH_#{translate(a).upcase}:BOOL=#{bool}"
    end

    if build.with? "sqlite"
      args << "-DSQLITE3_INCLUDE_DIR=/usr/local/opt/sqlite3/include"
      args << "-DSQLITE3_LIBRARIES=/usr/local/opt/sqlite3/lib/libsqlite3.dylib"
    end

    if build.with? "odbc"
      args << "-DODBC_INCLUDE_DIR=/usr/local/include"
      args << "-DODBC_LIBRARIES=/usr/local/lib/libodbc.dylib"
    end

    if build.with? "postgresql"
      args << "-DPostgreSQL_INCLUDE_DIR=/usr/local/include"
      args << "-DPostgreSQL_LIBRARIES=/usr/local/lib/libpq.dylib"
    end

    if build.with? "mysql"
      args << "-DMYSQL_INCLUDE_DIR=/usr/local/include/mariadb"
      args << "-DMYSQL_LIBRARIES=/usr/local/lib/mariadb/libmysqlclient.dylib"
    end

    system "cmake", ".", *args
    system "make"
    system "make", "install"

    mv "#{lib}/cmake/soci/SOCI.cmake", "#{lib}/cmake/soci/SOCIConfig.cmake"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <soci.h>
      int main() {
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lsoci", "-o", "test"
    system "./test"
  end
end
