require 'formula'

class GnuProlog < Formula
  homepage 'http://www.gprolog.org/'
  url 'http://www.gprolog.org/gprolog-1.4.1.tar.gz'
  sha1 'f25e11dbef2467c8ea1bb16cfd20623fd2f4fad4'

  fails_with :clang do
    build 318
    cause "Fatal Error: Segmentation Violation"
  end
  
  def patches; DATA; end

  def install
    ENV.j1 # make won't run in parallel
    cd 'src' do
      system "./configure", "--prefix=#{prefix}", "--with-doc-dir=#{doc}"
      system "make"
      system "make install-strip"
    end
  end
end

__END__
--- a/src/EnginePl/machine.h    8 Apr 2011 16:16:16 -0000    1.26
+++ b/src/EnginePl/machine.h    14 Nov 2011 12:38:04 -0000
@@ -149,6 +149,10 @@
 #define NO_MACHINE_REG_FOR_REG_BANK
 #endif

+#if defined(M_x86_64) && defined(NO_USE_REGS)
+#define NO_MACHINE_REG_FOR_REG_BANK
+#endif
+

 //#if defined(_MSC_VER) && defined(M_x86_64)
 //#define NO_MACHINE_REG_FOR_REG_BANK
