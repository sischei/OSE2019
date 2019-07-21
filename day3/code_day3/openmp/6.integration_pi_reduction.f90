!======================================================================      
!      
!     OpenMP example: program to approximation pi by a REDUCTION
!
!======================================================================   
      program integration_pi_reduction

      use omp_lib

      implicit none
      
      real(8) :: pi,w,x, time
      integer(8) :: i, N = 500000000

!----------------------------------------------------------------------
      pi = 0.d0
      w = 1.d0/N

!.....start timer
      time = -omp_get_wtime()            
      
!----------------------------------------------------------------------      
!$OMP PARALLEL PRIVATE(x) 
!$OMP DO REDUCTION(+:pi)
      do i = 1 , n
        x = w*(i-0.5d0)
        pi = pi + 4.d0/(1.d0+x*x)
      enddo
!$OMP END DO
!$OMP END PARALLEL

!.....end timer
      time = time + omp_get_wtime()

!----------------------------------------------------------------------      
      write(*,*) 'The approximation of Pi =', pi*w
      write(*,*) 'took ', time, ' seconds'            

!---------------------------------------------------------------------- 
      end program integration_pi_reduction
!----------------------------------------------------------------------
