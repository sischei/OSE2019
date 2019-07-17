#include<iostream>

#include<omp.h>

int main(void){
	int num_threads = omp_get_max_threads();
	std::cout << "sum with " << num_threads << "threads" << std::endl;
	
	int sum = 0;

	#pragma omp parallel 
	{
		sum += omp_get_thread_num() + 1;
	}

	//use formula for sum of arithmetic sequence: sum(1:n) = (n+1)*n/2
	int expected = (num_threads + 1)*num_threads/2;
	std::cout << " sum " << sum
		  << (sum==expected ? " which matches the expected value "
				    : " which does not match the expected value") << expected << std::endl;

	return 0;
}

