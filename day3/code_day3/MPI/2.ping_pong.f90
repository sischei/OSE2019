!==============================================================
!                                                              
!     Purpose: A program to test MPI_Ssend and MPI_Recv.            
!                  
!     Please run this program only with 2 MPI processes             
!==============================================================

      program ping_pong
 
      use mpi 
      
      implicit none 

      integer, parameter :: process_a = 0
      integer, parameter :: process_b = 1

      integer, parameter :: ping = 17 !message tag
      integer, parameter :: pong = 23 !message tag
 
      integer, parameter :: length = 1
      integer :: status(MPI_STATUS_SIZE)
      real :: buffer(length)
      integer :: i

      integer :: ierror, my_rank, size

!----------------------------------------------------------------------  
      call MPI_INIT(ierror)

      call MPI_COMM_RANK(MPI_COMM_WORLD, my_rank, ierror)
      call MPI_Comm_size(MPI_COMM_WORLD, size, ierror)

      
!.....the example should only be run with 2 procs, else abort
      if (size .ne. 2) then
        write(*,*) 'please run this with 2 processors'
        call MPI_Finalize(ierror)
        stop
      end if      
      
!----------------------------------------------------------------------        
!.....write a loop of number_of_messages iterations. Within the loop, process A sends a message
!.....(ping) to process B. After receiving the message, process B sends a message (pong) to process A) 
      if (my_rank .eq. process_a) then
        call MPI_SEND(buffer, length, MPI_REAL, process_b, PING, MPI_COMM_WORLD, ierror)
        call MPI_RECV(buffer, length, MPI_REAL, process_b, PONG, MPI_COMM_WORLD, status, ierror)
      else if (my_rank .eq. process_b) then
        call MPI_RECV(buffer, length, MPI_REAL, process_a, PING, MPI_COMM_WORLD, status, ierror)
        call MPI_SEND(buffer, length, MPI_REAL, process_a, PONG, MPI_COMM_WORLD, ierror)     
      end if

      write(*,*) 'Ping-pong on process complete - no deadlock on process', my_rank

      call MPI_FINALIZE(ierror)
!----------------------------------------------------------------------      
      end program ping_pong
!----------------------------------------------------------------------      
     
