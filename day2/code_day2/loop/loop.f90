!-----------------------------------------------------------------------
!
!     Program to demonstrate that loop ordering plays a role in Fortran
!     
!-----------------------------------------------------------------------

      program loop_wrong
           
      implicit none
      
      integer :: i, j!loop indices
      integer, parameter :: N = 10000  !array size
      real(8) :: mult_A(N,N), mult_B(N,N), prod(N,N)
      real(8) :: time_in,  time_out,  delta_1
      real(8) :: time_in2, time_out2, delta_2      
      
!-----------------------------------------------------------------------
!.....inizialize arrays      
      mult_A(:,:) = 1.0
      mult_B(:,:) = 1.0
      
!.....wrong loop ordering      
      call cpu_time(time_in)
      do i = 1, N
        do j = 1, N
          prod(i,j) = mult_A(i,j)*mult_B(i,j)
        end do
      end do
      call cpu_time(time_out)
      delta_1 = time_out - time_in
      
!.....correct loop ordering fortran    
      call cpu_time(time_in2)
      do j = 1, N
        do i = 1, N
          prod(i,j) = mult_A(i,j)*mult_B(i,j)
        end do
      end do      
      call cpu_time(time_out2)
      delta_2 = time_out2 - time_in2
      
!.....summarize results      
      write(*,*) " time to compute loop in wrong order"
      write(*,*) delta_1
      write(*,*) " time to compute loop in correct order"
      write(*,*) delta_2
      write(*,*) 
      write(*,*) " correct ordering is ", delta_1/delta_2, " times faster"
      
!-----------------------------------------------------------------------            
      end program
!-----------------------------------------------------------------------
