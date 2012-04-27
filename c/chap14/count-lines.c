#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{
  if (argc != 2) {
    printf("Error!\n");
    exit(1);
  }
  FILE *file = fopen(argv[1], "r");

  if (!file) {
    printf("Error! can not open a file.");
    exit(1);
  }

  int count = 0;
  int buf = NULL;

  while (buf != EOF) {
    buf = fgetc(file);
    if (buf == '\n') {
      count++;
    }
  }
  printf("%s: %d\n", argv[1], count);
  fclose(file);
  return 0;
}
