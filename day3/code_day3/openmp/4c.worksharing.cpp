/*
     Simple vector-add program
     Arrays A, B, C, and variable N will be shared by all threads.
     Variable i will be private to each thread; each thread will have its own unique copy.
     The iterations of the loop will be distributed dynamically in CHUNK sized pieces.
     Threads will not synchronize upon completing their individual pieces of work (NOWAIT)      
*/


#include <omp.h>
 #define N 1000
 #define CHUNKSIZE 100

 main(int argc, char *argv[]) {

 int i, chunk;
 float a[N], b[N], c[N];

 /* Some initializations */
 for (i=0; i < N; i++)
   a[i] = b[i] = i * 1.0;
 chunk = CHUNKSIZE;

 #pragma omp parallel shared(a,b,c,chunk) private(i)
   {

   #pragma omp for schedule(dynamic,chunk) nowait
   for (i=0; i < N; i++)
     c[i] = a[i] + b[i];

   }   /* end of parallel region */

 }
