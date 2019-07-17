###http://stackoverflow.com/questions/8924729/using-avx-intrinsics-instead-of-sse-does-not-improve-speed-why
###http://www.codeproject.com/Articles/874396/Crunching-Numbers-with-AVX-and-AVX
###or check -mavx as flag

g++ avx-intrinsics.cpp -O3 -march=native -o avx-example

