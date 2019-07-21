!==============================================================
!                                                             
!     split the communicator                        
!
!     https://computing.llnl.gov/tutorials/mpi/#Group_Management_Routines
!
!==============================================================
      
      program MPI_group
      
      use mpi 
      
      implicit none 

      integer, parameter :: nprocs = 8

      integer :: rank, new_rank, sendbuf, recvbuf, numtasks
      integer :: ranks1(4), ranks2(4), ierr
      integer :: orig_group, new_group, new_comm   ! required variables
      data ranks1 /0, 1, 2, 3/, ranks2 /4, 5, 6, 7/

      call MPI_INIT(ierr)
      
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
      
      call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr)

      if (numtasks .ne. NPROCS) then
        write(*,*) 'Must specify NPROCS= ',nprocs,' Terminating.'
        call MPI_FINALIZE(ierr)
        stop
      endif

      sendbuf = rank

!.....extract the original group handle
      call MPI_COMM_GROUP(MPI_COMM_WORLD, orig_group, ierr)

!.....divide tasks into two distinct groups based upon rank
      if (rank .lt. nprocs/2) then
        call MPI_GROUP_INCL(orig_group, nprocs/2, ranks1, new_group, ierr)
      else 
       call MPI_GROUP_INCL(orig_group, nprocs/2, ranks2, new_group, ierr)
      endif

!.....create new new communicator and then perform collective communications
      call MPI_COMM_CREATE(MPI_COMM_WORLD, new_group, new_comm, ierr)
      call MPI_ALLREDUCE(sendbuf, recvbuf, 1, MPI_INTEGER, MPI_SUM, new_comm, ierr)

!.....get rank in new group
      call MPI_GROUP_RANK(new_group, new_rank, ierr)
      write(*,*) 'rank= ',rank,' newrank= ',new_rank,' recvbuf= ', recvbuf

      call MPI_FINALIZE(ierr)
!----------------------------------------------------------------------        
      end program MPI_group
!----------------------------------------------------------------------        
    
