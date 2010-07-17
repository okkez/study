#include <stdio.h>
#include <stdlib.h>

int main(){
  char line[80];
  int price; /* 1 ドル (100 セント) 以下の金額 */
  div_t result;
  int c25, c10, c5, c1;

  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d", &price);

  result = div(price, 25);
  c25 = result.quot;
  result = div(result.rem, 10);
  c10 = result.quot;
  result = div(result.rem, 5);
  c5 = result.quot;
  c1 = result.rem;
  printf("%d %d %d %d\n", c25, c10, c5, c1);
  return 0;
}
