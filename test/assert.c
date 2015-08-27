#include <assert.h>
#include <stdio.h>

int foo() {
	int b = 77;
	++b;

	int a = 3;
	assert(a != b);

	printf("a is %d\n", a);

	puts("ok");

	return b;
}

int main() {
	int c = foo();

	return 0;
}
