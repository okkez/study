#include <stdio.h>

int main(){
  int row, col, inner_row;
  for(row = 0; row < 8; ++row){
    printf("+");
    for(col = 0; col < 8; ++col){
      printf("-----+");
    }
    printf("\n");
    for (inner_row = 0; inner_row < 3; ++inner_row){
      printf("|");
      for(col = 0; col < 8; ++col){
        printf("     |");
      }
      printf("\n");
    }
  }
  printf("+");
  for(col = 0; col < 8; ++col){
    printf("-----+");
  }
  printf("\n");
  return 0;
}
