#include <stdio.h>

int main() {
	int x, y;
	scanf("%d %d", &x, &y);
	int total = 0;
	int sum = 0;
	if (x <= 1) {
		sum = y;
	} else {
		int z;
		scanf("%d", &z);
		total = x * y;
	}
	printf("%d %d\n", total, sum);

	return 0;
}
