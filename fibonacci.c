/*
 * Run with a single number argument. Example:
 *   Command: ./fastfibonacci 7
 *   Output: "fibonacci(7) = 13"
 */

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>



unsigned long long int a,b,c,d;

void fast_fibonacci(long long int n,long long int ans[])
{
    if(n == 0)
    {
        ans[0] = 0;
        ans[1] = 1;
        return;
    }
    fast_fibonacci((n/2),ans);
    a = ans[0];                    /* F(n) */
    b = ans[1];                    /* F(n+1) */
    c = 2*b - a;                   /* (2F(n+1)-F(n)) */
    if(c < 0) c += ULLONG_MAX;
    c = (a * c) % ULLONG_MAX;      /* F(2n) */
    d = (a*a + b*b) % ULLONG_MAX;  /* F(2n + 1) */
    if(n%2 == 0)
    {
        ans[0] = c;
        ans[1] = d;
    }
    else
    {
        ans[0] = d;
        ans[1] = c+d;
    }
}
	
int main(int argc, char* argv []) {
        int n; /* nth value to be found */
		if (argc != 2) {
	    printf("USAGE: ./main  <n> \nWill use default max n=93 \n");
        n=93;
		}else
        {
           n = atoi(argv[1]);
           if (n < 0) {
			printf("Number must be non-negative\n");
			return 1;
		    }
        }
               
        unsigned long long int ans[2]={0};
        fast_fibonacci(n,ans);
        printf("\nfibonacci(%d) = %llu\n",n,ans[0]);
        return 0;
	}
	
	
	
	
    



