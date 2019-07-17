!======================================================================
      program pi_rand
!======================================================================
!
!     this program generates random numbers in [0,1]
!  
!......................................................................
      implicit none
      
      integer, parameter :: N = 10
      integer,parameter :: seed = 86456
      real(8) :: r_number
      integer :: i  
      
      
!.....generate N random numbers      
      call srand(seed)  !init. random sequence
      do i = 1, N
        r_number = rand()
        write(*,*) "random number i = ", i, " has value ", r_number
      end do
      

!======================================================================
      end program pi_rand
!======================================================================
