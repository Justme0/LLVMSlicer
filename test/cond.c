#include <assert.h>

int main() {
	int a = 0;
	int b = 0;
	if (a == 0) {
		b = 1;
	} else {
		b = 0;
	}
	assert(a == 0);
	a = 3;

	return 0;
}
