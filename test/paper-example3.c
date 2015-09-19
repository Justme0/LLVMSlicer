#include <stdio.h>

int main() {
	int x;
	scanf("%d", &x);
	int z;
	if (x < 1) {
		z = 1;
	} else {
		z = 2;
	}
	printf("%d", z);

	return 0;
}
