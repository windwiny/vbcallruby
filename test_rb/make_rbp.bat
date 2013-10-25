
set RUBYINFO=-I e:\ux\ruby2\include\ruby-2.0.0 -I e:\ux\ruby2\include\ruby-2.0.0\i386-mingw32 -L e:\ux\ruby2\lib -l msvcrt-ruby200

gcc -o rb_protect.exe rb_protect.c %RUBYINFO%

