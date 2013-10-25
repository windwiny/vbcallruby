
set RUBYINFO=-I e:\ux\ruby2\include\ruby-2.0.0 -Ie:\ux\ruby2\include\ruby-2.0.0\i386-mingw32 -L e:\ux\ruby2\lib -l msvcrt-ruby200

dlltool -e mydll.exp -d mydll.def

gcc -shared -o mydll.dll mydll.exp  mydll.c %RUBYINFO%
