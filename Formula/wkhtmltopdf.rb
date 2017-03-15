class Wkhtmltopdf < Formula
  desc "Convert HTML to PDF using Webkit (QtWebKit)"
  homepage "http://wkhtmltopdf.org"

  head do
    url "https://github.com/wkhtmltopdf/wkhtmltopdf/archive/merge-0.13.tar.gz"
    sha256 "b278597c47b9f76b116825e4a4fb7bb2baba51e7578bdf55897525640c67610a"
  end

  depends_on "qtwebkit" => :build

  patch :DATA

  def install
    ENV["WKHTMLTOX_VERSION"] = "0.13"
    system Formula["qt5"].bin/"qmake", "-config", "release", "PREFIX=#{prefix}"
    system "make"

    %w[dllbegin.inc dllend.inc image.h pdf.h].each do |a|
      (include/"wkhtmltox").install "include/wkhtmltox/#{a}"
    end
    bin.install Dir["bin/wkhtml*"]
    lib.install Dir["bin/*.dylib"]
  end
end

__END__
diff -r -c wkhtmltopdf.orig/src/lib/converter.cc wkhtmltopdf/src/lib/converter.cc
*** wkhtmltopdf.orig/src/lib/converter.cc	2017-03-10 21:47:26.694986300 -0300
--- wkhtmltopdf/src/lib/converter.cc	2017-03-10 21:47:49.371120800 -0300
***************
*** 63,69 ****
  	conversionDone = true;
  	clearResources();
  	emit outer().finished(false);
- 	qApp->exit(0); // quit qt's event handling
  }
  
  /*!
--- 63,68 ----
diff -r -c wkhtmltopdf.orig/src/lib/imageconverter.cc wkhtmltopdf/src/lib/imageconverter.cc
*** wkhtmltopdf.orig/src/lib/imageconverter.cc	2017-03-10 21:47:26.715616100 -0300
--- wkhtmltopdf/src/lib/imageconverter.cc	2017-03-10 21:47:49.371120800 -0300
***************
*** 228,235 ****
  	emit out.phaseChanged();
  	conversionDone = true;
  	emit out.finished(true);
- 
- 	qApp->exit(0); // quit qt's event handling
  }
  
  Converter & ImageConverterPrivate::outer() {
--- 228,233 ----
diff -r -c wkhtmltopdf.orig/src/lib/multipageloader.cc wkhtmltopdf/src/lib/multipageloader.cc
*** wkhtmltopdf.orig/src/lib/multipageloader.cc	2017-03-10 21:47:27.547987500 -0300
--- wkhtmltopdf/src/lib/multipageloader.cc	2017-03-10 21:52:11.130752500 -0300
***************
*** 316,322 ****
  
  	// XXX: If loading failed there's no need to wait
  	//      for javascript on this resource.
! 	if (!ok || signalPrint || settings.jsdelay == 0) loadDone();
  	else if (isMain && !settings.windowStatus.isEmpty()) waitWindowStatus();
  	else QTimer::singleShot(settings.jsdelay, this, SLOT(loadDone()));
  }
--- 316,322 ----
  
  	// XXX: If loading failed there's no need to wait
  	//      for javascript on this resource.
! 	if (!ok || signalPrint) loadDone();
  	else if (isMain && !settings.windowStatus.isEmpty()) waitWindowStatus();
  	else QTimer::singleShot(settings.jsdelay, this, SLOT(loadDone()));
  }
diff -r -c wkhtmltopdf.orig/src/lib/pdf_c_bindings.cc wkhtmltopdf/src/lib/pdf_c_bindings.cc
*** wkhtmltopdf.orig/src/lib/pdf_c_bindings.cc	2017-03-10 21:47:27.547987500 -0300
--- wkhtmltopdf/src/lib/pdf_c_bindings.cc	2017-03-10 21:47:49.371120800 -0300
***************
*** 287,296 ****
  	++usage;
  
  	if (qApp == 0) {
! 		char x[256];
  		strcpy(x, "wkhtmltox");
! 		char * arg[] = {x, 0};
! 		int aa = 1;
  
  		bool ug = true;
  #if defined(Q_OS_UNIX) || defined(Q_OS_MAC)
--- 287,296 ----
  	++usage;
  
  	if (qApp == 0) {
! 		static char x[256];
  		strcpy(x, "wkhtmltox");
! 		static char * arg[] = {x, 0};
! 		static int aa = 1;
  
  		bool ug = true;
  #if defined(Q_OS_UNIX) || defined(Q_OS_MAC)
diff -r -c wkhtmltopdf.orig/src/lib/pdfconverter.cc wkhtmltopdf/src/lib/pdfconverter.cc
*** wkhtmltopdf.orig/src/lib/pdfconverter.cc	2017-03-10 21:47:26.796248600 -0300
--- wkhtmltopdf/src/lib/pdfconverter.cc	2017-03-10 21:47:49.371120800 -0300
***************
*** 1055,1062 ****
  	emit out.phaseChanged();
  	conversionDone = true;
  	emit out.finished(true);
- 
- 	qApp->exit(0); // quit qt's event handling
  }
  
  #ifdef __EXTENSIVE_WKHTMLTOPDF_QT_HACK__
--- 1055,1060 ----
