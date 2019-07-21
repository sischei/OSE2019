#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
using namespace std;

int main()
  {
    const int N = 20;
    int nthreads, threadid;
    int i;
    double a[N], b[N], c[N];
    
    //Initialize
    for (i = 0; i < N; i++){
     a[i] = 1.0*i;
     b[i] = 2.0*i; 
    }
  
#pragma omp parallel shared(a,b,c,nthreads) private(i,threadid)
    {
    threadid = omp_get_thread_num();
    if (threadid ==0) {
      nthreads = omp_get_num_threads(); 
      printf("Number of threads = %d\n", nthreads);
    }
    printf("My threadid = %d\n", threadid);

#pragma omp for
    for (i = 0; i < N; i++){
	c[i] = a[i] + b[i];
	printf("Thread id = %d working on index %d\n", threadid,i);
    }
  
    }  //join
  
  cout << "TEST c[19] = " << c[19] << endl;

  return 0;
  }