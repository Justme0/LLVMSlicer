#include <assert.h>

int main() {
  int a = 2;
  int b = 1;
  for (;;) {
    b = 3;
    break;
  }
  assert(a == 2);

  return 0;
}
