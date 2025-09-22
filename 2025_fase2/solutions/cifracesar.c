#include <stdio.h>
#include <string.h>

char input[256];

void read(){
  for( int i=0 ; i<256 ; i++ ){
    input[i] = getchar();
    if( input[i] == '\n'
      || input[i] == '\0'
      || input[i]== EOF
    ){
      input[i] = '\0';
      break;
    }
  }
}

int getDiff( char before, char after ){
  return (after+26-before)%26;
}

void decrypt( char *str, int diff ){
  for( int i=0 ; str[i] != '\0' ; i++ ){
    if( str[i] >= 65 && str[i] <= 90 )
      str[i] = 65+(str[i]-65+26 - diff)%26;
  }
}

int main(){
  read();
  while( strcmp( input, "***" ) != 0 ){
    int length = strlen(input);
    int z = getDiff( 'E', input[length-1] );
    int y = getDiff( 'V', input[length-2] );
    if( y != z )
      z = getDiff( 'R', input[length-1] );
    decrypt( input, z );
    printf( "%s\n", input );
    read();
  }

  return 0;
}
