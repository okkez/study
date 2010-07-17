#include <stdio.h>
#include <math.h>

int main() {
  char line[80];
  int x1, y1;
  int x2, y2;
  double result;

  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d %d %d %d", &x1, &y1, &x2, &y2);

  result = pow(x2 - x1, 2.0) + pow(y2 - y1, 2.0);
  printf("%f\n", sqrt(result));

  return 0;
}
