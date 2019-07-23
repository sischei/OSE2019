!----------------------------------------------------------------------      
!     example program that send around a message   
!----------------------------------------------------------------------        
      program send_rec
      
      use mpi

      integer :: numtasks, rank, dest, source, count, tag, ierr
      integer :: stat(MPI_STATUS_SIZE)   ! required variable for receive routines
      integer, parameter :: bufsize = 1
      real :: inmsg, outmsg
      
!----------------------------------------------------------------------      
      outmsg = 4 
      tag = 1

      call MPI_INIT(ierr)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr)

      if (numtasks .ne. 2) THEN
        write(*,*) 'please run this with 2 processors'
        call MPI_Finalize(ierror)
        stop
      end if      
      
!----------------------------------------------------------------------            
!.....task 0 sends to task 1 and waits to receive a return message
      if (rank .eq. 0) then
        dest = 1
        source = 1
        call MPI_SEND(outmsg, bufsize, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, ierr)
        call MPI_RECV(inmsg, bufsize, MPI_DOUBLE, source, tag, MPI_COMM_WORLD, stat, ierr)

!..... task 1 waits for task 0 message then returns a message
      else if (rank .eq. 1) then
        dest = 0
        source = 0
        call MPI_RECV(inmsg, bufsize, MPI_DOUBLE, source, tag, MPI_COMM_WORLD, stat, err)
        call MPI_SEND(outmsg, bufsize, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, err)
     endif
     
     write(*,*) "in-message on rank", rank, " is ", inmsg     
     write(*,*) "out-message on rank", rank, " is ", outmsg   

     
!----------------------------------------------------------------------        
!....query recieve Stat variable and print message details
     call MPI_GET_COUNT(stat, MPI_DOUBLE, count, ierr)
     write(*,*) 'Task ',rank,': Received', count, 'double(s) from task', &
            stat(MPI_SOURCE), 'with tag',stat(MPI_TAG)
       
     call MPI_FINALIZE(ierr)

!----------------------------------------------------------------------      
      end program send_rec
!----------------------------------------------------------------------      
      