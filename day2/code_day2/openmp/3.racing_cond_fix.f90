!======================================================================      
!      
!     OpenMP example: Racing conditions example
!
!======================================================================   

      program racing_cond_fix

      use omp_lib

      implicit none

      integer :: num_threads, expected
      integer :: sum = 0

!----------------------------------------------------------------------      
      num_threads = omp_get_max_threads()
      write(*,*) 'sum with ', num_threads, ' threads'

!----------------------------------------------------------------------  
!.....section where we can have racing conditions
!$omp parallel

!.....all theads will execute block, one at at time
!$omp critical 
      sum = sum + omp_get_thread_num() + 1
!$omp end critical   

!$omp end parallel

!----------------------------------------------------------------------      
!.....use formula for sum of arithmetic sequence: sum(1:n) = (n+1)*n/2
      expected = (num_threads + 1)*num_threads/2
      
      if (sum .eq. expected) then
        write(*,*) "sum ", sum, ' matches the expected value'
      else
        write(*,*) "sum ", sum, ' does not match the expected value ', expected
      endif

!----------------------------------------------------------------------      
      end program racing_cond_fix
!----------------------------------------------------------------------
      

