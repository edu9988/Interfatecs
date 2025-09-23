#include <stdio.h>

int main(){
  int f, m, c;
  scanf( "%d %d %d", &f, &m, &c );

  int mesada = ((m/f)/10)*10;
  int resto = m - mesada*f;
  int mesada_ultimo = mesada+resto;

  int categoria[c];
  int categoria_ultimo[c];

  for( int i=0; i<c ; i++ ){
    if( mesada >= 30 ){
      categoria[i] = 30;
      mesada -= 30;
    }
    else if( mesada >= 20 ){
      categoria[i] = 20;
      mesada -= 20;
    }
    else if( mesada >= 10 ){
      categoria[i] = 10;
      mesada -= 10;
    }
    else{
      categoria[i] = 0;
    }

    if( mesada_ultimo >= 30 ){
      categoria_ultimo[i] = 30;
      mesada_ultimo -= 30;
    }
    else if( mesada_ultimo >= 20 ){
      categoria_ultimo[i] = 20;
      mesada_ultimo -= 20;
    }
    else if( mesada_ultimo >= 10 ){
      categoria_ultimo[i] = 10;
      mesada_ultimo -= 10;
    }
    else{
      categoria_ultimo[i] = 0;
    }
  }
  
  for( int i=0; i<f-1 ; i++ ){
    for( int j=0 ; j<c-1 ; j++ )
      printf( "%d ", categoria[j] );
    printf( "%d\n", categoria[c-1] );
  }
  for( int j=0 ; j<c-1 ; j++ )
    printf( "%d ", categoria_ultimo[j] );
  printf( "%d\n", categoria_ultimo[c-1] );

  return 0;
}
