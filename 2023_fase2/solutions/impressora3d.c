#include <stdio.h>
#include <stdlib.h>

int main(){
  int width, height, commands, MAX;
  scanf( "%d %d %d" , &width, &height, &commands );

  int *printer, *diff;
  printer = malloc( (width+1)*sizeof(int) );
  diff = malloc( (width+2)*sizeof(int) );
  for( int i=0 ; i<=width ; i++ ){
    printer[i] = 0;
    diff[i] = 0;
  }
  diff[width+1] = 0;
  MAX = 0;

  for( int i=0 ; i<commands ; i++ ){
    int a, b, c;
    scanf( "%d %d %d" , &a, &b, &c );
    diff[a] += c;
    diff[b+1] -= c;
  }

  if( diff[0] >= height ){
    printf( "invalida\n" );
    free(printer);
    free(diff);
    return 0;
  }
  printer[0] = diff[0];
  for( int i=1 ; i<=width ; i++ ){
    printer[i] = printer[i-1]+diff[i];
    if( printer[i] > MAX )
      MAX = printer[i];
    if( printer[i] >= height ){
      printf( "invalida\n" );
      free(printer);
      free(diff);
      return 0;
    }
  }
  printf( "%d\n" , MAX );

  free(printer);
  free(diff);
  return 0;
}
