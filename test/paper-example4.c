#include <stdio.h>
#include <stdbool.h>

bool P(int num) {
	return num < 3;
}

bool Q(int num) {
	return num % 2 == 0;
}

int main() {
	int A = 12;
	int B = 2;
	int C = 5;
	int K = 0;
	int X = 0;
	int Y = 0;
	int Z = 0;

	while (P(K)) {
		if (Q(C)) {
			B = A;
			X = 1;
		} else {
			C = B;
			Y = 2;
		}
		K = K + 1;
	}
	Z = X + Y;
	printf("%d\n", Z);

	return 0;
}
