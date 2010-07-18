#include <stdio.h>

char line[100];
int result;
char operator;
int value;

int main(){
  result = 0;

  while(1){
    printf("Result: %d\n", result);
    printf("Enter operator and number: ");
    fgets(line, sizeof(line), stdin);
    sscanf(line, "%c %d", &operator, &value);

    if (operator == '+') {
      result += value;
    } else {
      printf("Unknown operator %c\n", operator);
    }
  }
  return 0;
}
