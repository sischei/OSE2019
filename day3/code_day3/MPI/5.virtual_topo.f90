!==============================================================
!                                                             
!     virtual topology                      
!
!     https://computing.llnl.gov/tutorials/mpi/
!
!==============================================================

      program virtual_topo
      
      include 'mpif.h'

      integer size, UP, DOWN, LEFT, RIGHT
      parameter(size=16)
      parameter(UP=1)
      parameter(DOWN=2)
      parameter(LEFT=3)
      parameter(RIGHT=4)
      integer numtasks, rank, source, dest, outbuf, i, tag, ierr, &
           inbuf(4), nbrs(4), dims(2), coords(2), periods(2), reorder
      integer stats(MPI_STATUS_size, 8), reqs(8)
      integer cartcomm   ! required variable
      data inbuf /MPI_PROC_NULL,MPI_PROC_NULL,MPI_PROC_NULL,MPI_PROC_NULL/, &
        dims /4,4/, tag /1/, periods /0,0/, reorder /0/ 

      call MPI_INIT(ierr)
      call MPI_COMM_size(MPI_COMM_WORLD, numtasks, ierr)
  
      if (numtasks .eq. size) then
!.....create cartesian virtual topology, get rank, coordinates, neighbor ranks
        call MPI_CART_CREATE(MPI_COMM_WORLD, 2, dims, periods, reorder, &
                           cartcomm, ierr)
        call MPI_COMM_RANK(cartcomm, rank, ierr)
        call MPI_CART_COORDS(cartcomm, rank, 2, coords, ierr)
        call MPI_CART_SHIFT(cartcomm, 0, 1, nbrs(UP), nbrs(DOWN), ierr)
        call MPI_CART_SHIFT(cartcomm, 1, 1, nbrs(LEFT), nbrs(RIGHT), ierr)

        write(*,20) rank,coords(1),coords(2),nbrs(UP),nbrs(DOWN), &
                  nbrs(LEFT),nbrs(RIGHT)

!.......exchange data (rank) with 4 neighbors
        outbuf = rank
        do i=1,4
          dest = nbrs(i)
          source = nbrs(i)
          call MPI_ISEND(outbuf, 1, MPI_INTEGER, dest, tag, &
                       MPI_COMM_WORLD, reqs(i), ierr)
          call MPI_IRECV(inbuf(i), 1, MPI_INTEGER, source, tag, &
                       MPI_COMM_WORLD, reqs(i+4), ierr)
        enddo

        call MPI_WAITALL(8, reqs, stats, ierr)

        write(*,30) rank,inbuf

      else
        write(*,*) 'Must specify',size,' processors.  Terminating.' 
      endif

      call MPI_FINALIZE(ierr)

20    format('rank= ',I3,' coords= ',I2,I2, &
             ' neighbors(u,d,l,r)= ',I3,I3,I3,I3 )
30    format('rank= ',I3,'                 ', &
             ' inbuf(u,d,l,r)= ',I3,I3,I3,I3 )

!----------------------------------------------------------------------                   
      end program virtual_topo
!----------------------------------------------------------------------        
        