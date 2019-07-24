!----------------------------------------------------------------------   
      program pi_parallel
!----------------------------------------------------------------------   
    
      use omp_lib

      implicit none

      integer :: num_steps = 500000000
      integer :: i
      real(8) :: x, pi, pi_reference, sum, w, time, error

!----------------------------------------------------------------------         
      pi=0.0
      sum=0.0

      write(*,*) "using ", omp_get_max_threads(), " OpenMP threads"

!----------------------------------------------------------------------   
!.....start timer
      time = -omp_get_wtime()

      w = 1.0d0/num_steps

!----------------------------------------------------------------------   
!$omp parallel do reduction(+:sum) shared(w) private(x)
     do i=1,num_steps
       x = (i-0.5d0)*w;
       sum = sum + 4.0d0/(1.0d0+x*x);
     enddo
!$omp end parallel do

!.....estimate pi
      pi = w*sum

      time = time + omp_get_wtime()

!.....calculate the relative error of our estimation
      pi_reference = 3.141592653589793238462643383279502884d0
      error = abs(pi-pi_reference)/pi_reference

      write(*,*) num_steps, " steps approximates pi as : ", pi, ", with relative error ", error
      write(*,*) "the solution took ", time, " seconds"

!----------------------------------------------------------------------         
      end program pi_parallel
!----------------------------------------------------------------------   
