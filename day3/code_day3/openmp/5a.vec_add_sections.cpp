/*======================================================================
!
     Simple program demonstrating that different blocks of work 
     will be done by different threads.

     cf. https://computing.llnl.gov/tutorials/openMP/#SECTIONS

!======================================================================*/

#include <omp.h>
#include <iostream>
#define N 1

using namespace std;

 main(int argc, char *argv[]) {

 int i;
 float a[N], b[N], c[N], d[N];

 /* Some initializations */
 for (i=0; i < N; i++) {
   a[i] = i * 1.5;
   b[i] = i + 22.35;
   }

 #pragma omp parallel shared(a,b,c,d) private(i)
   {

   #pragma omp sections nowait
     {

     #pragma omp section
     for (i=0; i < N; i++)
     {
       c[i] = a[i] + b[i];
       cout << "Section 1: hello from thread " << omp_get_thread_num() << " of " << omp_get_num_threads() << " index  " << i << endl; 
     }
     #pragma omp section
     for (i=0; i < N; i++)
     {
       d[i] = a[i] * b[i];
       cout << "Section 2: hello from thread " << omp_get_thread_num() << " of " << omp_get_num_threads() << " index  " << i << endl; 
     }
     
     #pragma omp section
     {
       cout << "Section 3: hello from thread " << omp_get_thread_num() << " of " << omp_get_num_threads() << endl; 
       cout << "This section 3 does nothing" << endl;
     }     
     
     
     
     }  /* end of sections */

   }  /* end of parallel region */

 }