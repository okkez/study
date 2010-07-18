#include <stdio.h>

int main(){
  float result;
  char line[80];
  int ohm1, ohm2, ohm3;

  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d %d", &ohm1, &ohm2);
  result = 1.0 / (1.0 / ohm1 + 1.0 / ohm2);
  while(1){
    fgets(line, sizeof(line), stdin);
    sscanf(line, "%d", &ohm3);
    if(ohm3 == 0){
      break;
    }
    result = 1.0 / (1.0 / result + 1.0 / ohm3);
  }

  printf("%f\n", result);
  return 0;
}
