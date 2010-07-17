#include <stdio.h>
#include <string.h>

int main(){
  char line[80];
  char grade[10];
  int point = 0;
  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d", &point);
  if (point <= 60) {
    strcpy(grade, "F");
  } else if (61 <= point && point <= 70) {
    strcpy(grade, "D");
  } else if (71 <= point && point <= 80) {
    strcpy(grade, "C");
  } else if (81 <= point && point <= 90) {
    strcpy(grade, "B");
  } else if (91 <= point && point <= 100) {
    strcpy(grade, "A");
  }
  printf("%s\n", grade);
  return 0;
}
