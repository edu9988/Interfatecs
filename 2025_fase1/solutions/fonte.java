import java.util.Scanner;

public class fonte{
  public static void main( String[] args ){
    Scanner myReader = new Scanner( System.in );

    int T = myReader.nextInt();
    int V = myReader.nextInt();
    int C = myReader.nextInt();
    int M = myReader.nextInt();

    int vale = (T*C + 2*T*M)*2;
    int colina = (T*V + T*M)*2;
    int montanha = (2*T*V + T*C)*2;

    System.out.println( Math.min(vale, Math.min(colina, montanha)) );
  }
}
