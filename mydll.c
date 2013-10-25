#include <stdio.h>
#include "ruby.h"

// ruby function is cdecl, must convert to stdcall.
__stdcall void vbrb_init() {
	int argc2 = 0;
	char **argv2 = NULL;

	ruby_sysinit(&argc2, &argv2);
	RUBY_INIT_STACK;
	ruby_init();
	ruby_init_loadpath();	
	rb_eval_string("$:<< '.' ");
}

__stdcall void vbrb_cleanup() {
	ruby_cleanup(0);
}

__stdcall void vbrb_eval_string(char *rbstr) {
	printf("rb_eval_string %s", rbstr);
	rb_eval_string(rbstr);
}



__stdcall void t() {
	printf(" t\n"  );
}

__stdcall int nt() {
	printf(" nt\n"  );
	return 2;
}

// no return 
__stdcall char* st() {
	static char glo_s[6]="stst";
	printf(" st\n"  );
	return glo_s;
}

__stdcall void ti(int i) {
	printf("  ti  %d\n",  i );
}
__stdcall char* ts( char* s) {
	printf(" ts %s  \n", s );
	return s;
}

__stdcall char * encode(char* oribyte, long orilong) {
	printf("%s   %d\n", oribyte, orilong );
	return oribyte;
}

int main(int argc, char **argv) {
	VALUE result;  
	
	vbrb_init(argc, argv);
	printf("init ok\n");
	
	vbrb_eval_string("puts $:; puts RUBY_VERSION; a=1;p local_variables;p Dir.pwd.encoding");
	printf("5\n");
	
	rb_require("sum"); // or sum.rb 
	printf("6\n");
	
	vbrb_eval_string("$summer = Summer.new"); 
	vbrb_eval_string("p local_variables;p Dir.pwd.encoding");
	printf("7\n");
	
	vbrb_eval_string("$result = $summer.sum(10)"); 
	
	printf("8\n");
	result = rb_gv_get("result"); 

	printf("Result = %d\n", NUM2INT(result)); 

	vbrb_cleanup();
	return 0;
}

