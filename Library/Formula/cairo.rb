require 'formula'

# Use a mirror because of:
# http://lists.cairographics.org/archives/cairo/2012-September/023454.html

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.12.4.tar.xz'
  mirror 'http://ftp-nyc.osuosl.org/pub/gentoo/distfiles/cairo-1.12.4.tar.xz'
  sha256 'a467b2e1f04bfd3f848370ce5e82cfe0a7f712bac05a04d133bc34c94f677a28'

  keg_only :provided_pre_mountain_lion

  option :universal
  option 'without-x', 'Build without X11 support'

  env :std if build.universal?

  depends_on :libpng
  depends_on 'pixman'
  depends_on 'pkg-config' => :build
  depends_on 'xz'=> :build
  depends_on 'glib' unless build.include? 'without-x'
  depends_on :x11 unless build.include? 'without-x'

  def patches
    DATA if MacOS.version <= :snow_leopard
  end

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << '--with-x' unless build.include? 'without-x'
    args << '--enable-xcb=no' if MacOS.version == :leopard

    system "./configure", *args
    system "make install"
  end
end

__END__
diff --git a/src/cairo-xlib-surface-shm.c b/src/cairo-xlib-surface-shm.c
index 08169f2..6a1752d 100644
--- a/src/cairo-xlib-surface-shm.c
+++ b/src/cairo-xlib-surface-shm.c
@@ -51,7 +51,7 @@
 #include <X11/Xlibint.h>
 #include <X11/Xproto.h>
 #include <X11/extensions/XShm.h>
-#include <X11/extensions/shmproto.h>
+#include <X11/extensions/shmstr.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
 
