!======================================================================      
!      
!     OpenMP example: program to approximation pi
!
!     Note: the initial value of sum is copied to the private instances
!     via the FIRSTPRIVATE clause on the PARALLEL directive
!
!======================================================================   
      program integration_pi

      use omp_lib

      implicit none
      
      real(8) :: pi,w,sum,x, time
      integer(8) :: i, N = 500000000

!----------------------------------------------------------------------
      pi = 0.d0
      w = 1.d0/N
      sum = 0.d0

!.....start timer
      time = -omp_get_wtime()      
!----------------------------------------------------------------------      
!$OMP PARALLEL PRIVATE(x) FIRSTPRIVATE(sum)
!$OMP DO
      do i = 1 , n
        x = w*(i-0.5d0)
        sum = sum + 4.d0/(1.d0+x*x)
      enddo
!$OMP END DO

!$OMP CRITICAL
      pi= pi + w*sum
!$OMP END CRITICAL
!$OMP END PARALLEL

!.....end timer
      time = time + omp_get_wtime()

!----------------------------------------------------------------------      
      write(*,*) 'The approximation of Pi =', pi
      write(*,*) 'took ', time, ' seconds'      
 
!---------------------------------------------------------------------- 
      end program integration_pi
!----------------------------------------------------------------------
