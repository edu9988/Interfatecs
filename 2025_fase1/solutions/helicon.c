#include <stdio.h>

int solve( int*, int );

int main(){
  int N;
  scanf( "%d" , &N );

  int arr[N];
  for( int i=0 ; i<N ; i++ )
    scanf( "%d" , arr+i );

  printf( "%d\n" , solve(arr,N) );
  return 0;
}

int solve( int *arr , int N ){
  int maxSum = arr[0];

  for( int k=1 ; k<N/2+1 ; k++ ){
    for( int i=0 ; i<k ; i++ ){
      int currentSum = arr[i];
      if( currentSum > maxSum )
        maxSum = currentSum;
      for( int j=i+k ; j<N ; j+=k ){
        if( currentSum < 0 )
          currentSum = arr[j];
        else
          currentSum += arr[j];
        if( currentSum > maxSum )
          maxSum = currentSum;
      }
    }
  }
  
  return maxSum;
}
