#include "ruby.h"

static int id_sum;
int Values[] = { 5, 10, 15, -1, 20, 0 }; 

char* cmds[] = {"p $:",  "p RUBY_VERSION",  "p RUBY_PATCHLEVEL" , "?", "x", "defined? c", "??", "1/", "asdfasf", "sdfÂÒ", "puts '×Ö·û'"};
int II = 11;

static VALUE wrap_sum(VALUE args) {
	VALUE *values = (VALUE *)args;
	VALUE summer = values[0];
	VALUE max = values[1];
	return rb_funcall(summer, id_sum, 1, max);
}
static VALUE protected_sum(VALUE summer, VALUE max) {
	int error;
	VALUE args[2];
	VALUE result;
	args[0] = summer;
	args[1] = max;
	result = rb_protect(wrap_sum, (VALUE)args, &error); 
	return error ? Qnil : result;
}

static VALUE wrap_eval(VALUE args) {
	char *str = (char *)args;
	return rb_eval_string(str);
}

static VALUE xxx(char *str) {
	int error;
	VALUE result;
	VALUE args = rb_str_new2(str);
	result = rb_protect(wrap_eval, (VALUE)str, &error); 
	error ? printf("eval error\n") : printf("eval ok\n");
	return error ? Qnil : result;
}

int main(int argc, char **argv) {
	int value;
	int *next = Values;
	char *cmd = cmds[0];
	char *c ;
	int i;
	int error; 
	ruby_sysinit(&argc, &argv); 
	RUBY_INIT_STACK; 
	ruby_init();

	ruby_init_loadpath();
	
	ruby_script("demo_embedder"); /* sets name in error messages */ 
	rb_protect((VALUE (*)(VALUE))rb_require, (VALUE)"./sum", &error); 
	// get an instance of Summer
	VALUE summer = rb_class_new_instance(0, 0, 
				rb_const_get(rb_cObject, rb_intern("Summer"))); 
	id_sum = rb_intern("sum");
	while (value = *next++) {
		VALUE result = protected_sum(summer, INT2NUM(value)); 
		if (NIL_P(result))
			printf("Sum to %d doesn't compute!\n", value); 
		else
			printf("Sum to %d is %d\n", value, NUM2INT(result)); 
	}
	printf("----------------------------------------------------\n\n");
	
	//while (c=cmd++) {
	for (i=0;i<II;i++) {
		c = cmds[i];
		printf("\n --> %s\n", c);
		VALUE result = xxx(c); 
	}
	
	printf("----------------------------------------------------\n\n");

	
	for (i=0;i<II;i++) {
		c = cmds[i];
		printf("\n --> %s\n", c);
		rb_eval_string_protect(c, &error);
		if (error != 0)
			printf("eval error\n"); 
		else
			printf("eval ok\n"); 
	}
	
	printf("----------------------------------------------------\n\n");
	
	return ruby_cleanup(0); 
}
