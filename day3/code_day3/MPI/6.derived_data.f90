!==============================================================
!                                                             
!     example for derived data types                       
!
!     https://computing.llnl.gov/tutorials/mpi/#Derived_Data_Types
!
!==============================================================

      program derived_datatype
      
      use mpi

      implicit none
      
      integer :: SIZE
      parameter(SIZE=4)
      integer :: numtasks, rank, source, dest, tag, i,  ierr
      real :: a(0:SIZE-1,0:SIZE-1), b(0:SIZE-1)
      integer :: stat(MPI_STATUS_SIZE)
      integer :: columntype   ! required variable

      
      tag = 1
!..... Fortran stores this array in column major order
      data a  /1.0, 2.0, 3.0, 4.0, &
            5.0, 6.0, 7.0, 8.0, &
            9.0, 10.0, 11.0, 12.0, & 
            13.0, 14.0, 15.0, 16.0 /            
            
      call MPI_INIT(ierr)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr)

!.....create contiguous derived data type
      call MPI_TYPE_CONTIGUOUS(SIZE, MPI_REAL, columntype, ierr)
      call MPI_TYPE_COMMIT(columntype, ierr)
  
      if (numtasks .eq. SIZE) then
!.....task 0 sends one element of columntype to all tasks
        if (rank .eq. 0) then
          do i=0, numtasks-1
            call MPI_SEND(a(0,i), 1, columntype, i, tag, MPI_COMM_WORLD,ierr)
          end do
        endif

!.......all tasks receive columntype data from task 0
        source = 0
        call MPI_RECV(b, SIZE, MPI_REAL, source, tag, MPI_COMM_WORLD, stat, ierr)
        write(*,*) 'rank= ',rank,' b= ',b
      else
        write(*,*), 'Must specify',SIZE,' processors.  Terminating.' 
      endif

!.....free datatype when done using it
      call MPI_TYPE_FREE(columntype, ierr)
      call MPI_FINALIZE(ierr)

!----------------------------------------------------------------------           
      end program derived_datatype
!----------------------------------------------------------------------        
      
