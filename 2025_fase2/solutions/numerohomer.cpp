//solution by prof. lucas
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

void format_time(double v, long &m, long &s, long &ml) {
  m = v;
  v -= m;
  s = v * 60;
  v = (v * 60) - s;
  ml = v * 1000;
}

int main (int argc, char *argv[]) {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);

  long n, m, s, ml;
  while (cin >> n) {
    if (n == 0)
      break;
    long ibot = 1;
    while (pow(ibot, ibot) < n)
      ibot++;
    if (pow(ibot, ibot) == n)
      format_time(ibot, m, s, ml);
    else {
      double bot = ibot-1;
      double top = bot+1;
      double mid = (bot + top) / 2;
      double q = pow(mid, mid);
      while (fabs(q - n) >= 0.001) {
        if (q > n) 
          top = mid;
        else 
          bot = mid;
        mid = (bot + top) / 2;
        q = pow(mid, mid);
      }
      format_time(mid, m, s, ml);
    }
    cout << m << ":" << setfill('0') << setw(2) << s << ":" << setfill('0') << setw(3) << ml << "\n";
  }

  return 0;
}
