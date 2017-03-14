class Soci < Formula
  desc "The C++ Database Access Library"
  homepage "https://soci.sourceforge.io/"
  head "https://github.com/SOCI/soci.git",
    :revision => "e719c44bb89949d3c179a6390de57ccd9046878b"

  depends_on "cmake" => :build
  depends_on "boost" => :optional
  depends_on "sqlite" => :optional
  depends_on "postgresql" => :optional
  depends_on "unixodbc" => :optional
  depends_on "libiodbc" => :optional
  depends_on "mariadb-connector-c" => :optional
  depends_on "mysql-connector-c" => :optional

  def translate(a)
    case a
    when "sqlite" then "sqlite3"
    when "unixodbc" then "odbc"
    when "libiodbc" then "odbc"
    when "mariadb-connector-c" then "mysql"
    when "mysql-connector-c" then "mysql"
    else a
    end
  end

  def install
    if build.with?("unixodbc") && build.with("libiodbc")
      odie "Options --with-unixodbc and --with-libiodbc are mutually exclusive."
    end
    if build.with?("mariadb-connector-c") && build.with("mysql-connector-c")
      odie "Options --with-mariadb-connector-c and --with-mysql-connector-c are mutually exclusive."
    end

    inreplace "./cmake/SociConfig.cmake" do |s|
      s.gsub! /-pedantic -Werror/, ""
      s.gsub! /-Wredundant-decls/, ""
    end
    inreplace "./src/core/CMakeLists.txt", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"
    inreplace "./cmake/SociBackend.cmake", "DESTINATION cmake", "DESTINATION ${LIBDIR}/cmake/soci"

    args = %w[-DSOCI_TESTS=OFF]

    %w[boost sqlite postgresql unixodbc libiodbc mariadb-connector-c mysql-connector-c].each do |a|
      bool = build.with?(a) ? "ON" : "OFF"
      args << "-DWITH_#{translate(a).upcase}:BOOL=#{bool}"
    end

    if build.with? "sqlite"
      args << "-DSQLITE3_INCLUDE_DIR=/usr/local/opt/sqlite3/include"
      args << "-DSQLITE3_LIBRARIES=/usr/local/opt/sqlite3/lib/libsqlite3.dylib"
    end
  
    if build.with? "unixodbc"
      args << "-DODBC_INCLUDE_DIR=/usr/local/include"
      args << "-DODBC_LIBRARIES=/usr/local/lib/libodbc.dylib"
    end

    if build.with? "postgresql"
      args << "-DPostgreSQL_INCLUDE_DIR=/usr/local/include"
      args << "-DPostgreSQL_LIBRARIES=/usr/local/lib/libpq.dylib"
    end
  
    if build.with? "mariadb-connector-c"
      args << "-DMYSQL_INCLUDE_DIR=/usr/local/include/mariadb"
      args << "-DMYSQL_LIBRARIES=/usr/local/lib/mariadb/libmysqlclient.dylib"
    end

    system "cmake", ".", *std_cmake_args, *args
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
