#include <stdio.h>

int main(){
  char line[80];
  float total = 0;
  int count = 0;
  int tmp;
  while(1){
    fgets(line, sizeof(line), stdin);
    sscanf(line, "%d", &tmp);
    if (tmp == 0){
      break;
    }
    total += tmp;
    count++;
  }
  printf("%f\n", total/count);
  return 0;
}
