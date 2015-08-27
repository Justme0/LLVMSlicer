void __ai_load(int a) {
	a = 777;
}

int main() {
	int a = 333;
	__ai_load(a);

	return 0;
}
