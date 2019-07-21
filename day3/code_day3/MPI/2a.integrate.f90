!======================================================================      
!      
!     MPI example: Integrate f(x) = x, x in [0,2]
!
!======================================================================  

      program integrate
      
      use mpi

      implicit none

      integer :: ierror, rank, size
      integer :: i
      real :: a, b, res
      real :: mya, myb
      real :: psum, tmp

      integer, parameter :: length = 1
      integer :: status(MPI_STATUS_SIZE)
      real :: buffer(length)      
      
!----------------------------------------------------------------------      
      call MPI_INIT(ierror)   !start MPI

!----------------------------------------------------------------------      
!.....Get the rank of each process
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)

!----------------------------------------------------------------------      
!.....Get the size of the communicator
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)

!----------------------------------------------------------------------      
!.....Write code such that every process writes its rank and the 
!.....size of the communicator, but only process 0 prints "hello world"
      if (rank .eq. 0) then
        write(*,*) 'Hello world!'
      end if

!----------------------------------------------------------------------
!.....every process does something 
      write(*,*) 'I am process', rank, ' out of', size
      
!.....integration limits
      a=0.d0 
      b=2.d0 
      
!.....initialise integral to 0
      res=0.d0
      
!.....limits for "me" -- split work 
      mya = a + rank*(b-a)/size
      myb = mya + (b-a)/size
      write(*,*) 'upper range ', myb, ' and lower range', mya, 'of process' , rank
   
!... .integrate f(x) over my own chunk - actual work -> integrate(mya,myb)
      psum = 0.5*(myb**2.0 - mya**2.0)
      
!.....rank 0 collects partial results
      if(rank.eq.0) then
        res=psum
        do i = 1, size - 1
          call MPI_Recv(tmp, 1, MPI_DOUBLE_PRECISION, i, 0, MPI_COMM_WORLD,& 
     &                  status, ierror)

          res=res+tmp
        enddo
      
        write(*,*) "Result: ",res
!.....ranks != 0 send their results to rank 0
      else
        call MPI_Send(psum, 1, MPI_DOUBLE_PRECISION, 0, 0, MPI_COMM_WORLD,ierror) 
      end if
      
      call MPI_FINALIZE(ierror)
      
!======================================================================         
      end program integrate
!======================================================================   
