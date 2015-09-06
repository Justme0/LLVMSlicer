#include <stdio.h>

int main() {
	int x;
	scanf("%d", &x);
	if (0 == x) {
		for(;;) {
		}
		x = 1;
	} else {
		x = 2;
	}

	return 0;
}
