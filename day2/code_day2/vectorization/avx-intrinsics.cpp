#include <immintrin.h>
#include <iostream>
#include <math.h> 
#include <sys/time.h>

using namespace std;

// -----------------------------------------------------------------------------
// This function returns the current time, expressed as seconds 
// -----------------------------------------------------------------------------
double getCurrentTime(){
  struct timeval curr;
  struct timezone tz;
  gettimeofday(&curr, &tz);
  double tmp = static_cast<double>(curr.tv_sec) * static_cast<double>(1000000)
             + static_cast<double>(curr.tv_usec);
  return tmp*1e-6;
}

// -----------------------------------------------------------------------------
// Main routine
// -----------------------------------------------------------------------------
int main() {

  srand48(0);            // seed PRNG
  double e,s;            // timestamp variables
  double res1, res2;     // results
  float *a, *b;          // data pointers
  float *pA,*pB;         // work pointer
  __m256 rA_AVX, rB_AVX; // variables for AVX

  // define vector size 
  const int vector_size = 10000000;

  // allocate memory 
  a = (float*) _mm_malloc (vector_size*sizeof(float),32);
  b = (float*) _mm_malloc (vector_size*sizeof(float),32);

  // initialize vectors //
  for(int i=0;i<vector_size;i++) {
    a[i]=fabs(drand48());
    b[i]=0.0f;
  }

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Naive implementation
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  s = getCurrentTime();
  for (int i=0; i<vector_size; i++){
    b[i] = sqrtf(sqrtf(sqrtf(a[i])));
  }
  e = getCurrentTime();
  res1 = (e-s)*1000;
  cout << "Naive implementation  " << res1 << " ms" << ", b[42] = " << b[42] << endl;

// -----------------------------------------------------------------------------
  for(int i=0;i<vector_size;i++) {
    b[i]=0.0f;
  }
// -----------------------------------------------------------------------------


// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// AVX implementation
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  pA = a; pB = b;

  s = getCurrentTime();
  for (int i=0; i<vector_size; i+=8){
    rA_AVX   = _mm256_load_ps(pA);
    rB_AVX   = _mm256_sqrt_ps(_mm256_sqrt_ps(_mm256_sqrt_ps(rA_AVX)));
    _mm256_store_ps(pB,rB_AVX);
    pA += 8;
    pB += 8;
  }
  e = getCurrentTime();
  res2 = (e-s)*1000;
  cout <<"AVX:  "<< res2 << " ms" << ", b[42] = " << b[42] << endl;

  cout << "SPEEDUP due to AVX " << res1/res2 << endl;
  
  _mm_free(a);
  _mm_free(b);

  return 0;
}