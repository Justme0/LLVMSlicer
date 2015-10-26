#include <assert.h>


int main() {
	int a, b;
	int g;
	a = g;
	g = b;
	assert(g == 123);

	return 0;
}
