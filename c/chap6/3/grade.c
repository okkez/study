#include <stdio.h>
#include <string.h>

int main(){
  char line[80];
  char grade[10];
  char subgrade[10];
  int point = 0;
  int rest = 0;
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
  if (strcmp(grade, "F") == 0){
    printf("%s\n", grade);
  } else {
    rest = point % 10;
    if (1 <= rest && rest <= 3){
      strcpy(subgrade, "-");
    } else if (4 <= rest && rest <= 7) {
      strcpy(subgrade, " ");
    } else {
      strcpy(subgrade, "+");
    }
    printf("%s%s\n", grade, subgrade);
  }
  return 0;
}
