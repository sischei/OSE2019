!======================================================================      
!      
!     OpenMP example: Hello World from tread xyz 
!
!     Every thread executes all code enclosed in the parallel section
!
!     OpenMP library routines are used to obtain thread id and total
!     number of threads
!
!======================================================================      
     
      program hello_world     
      
      use omp_lib      !module with API declarations

      integer :: tid   !thread ID

!----------------------------------------------------------------------
      write(*,*) '=== serial section ==='

      write(*,*) 'hello world from thread ', omp_get_thread_num(), ' of ', omp_get_num_threads()

!----------------------------------------------------------------------
      write(*,*) '=== parallel section ==='
!$omp parallel private(tid)    

!.....get thead ID
      tid = omp_get_thread_num();

!.....write a personalized message from this thread
      write(*,*) 'hello world from thread ', omp_get_thread_num(), ' of ', omp_get_num_threads()

!.....section only executed by master
      if(tid .eq. 0 ) then
        write(*,*) 'hello world from master thread with TID = ', tid
      end if
 
!....All threads join master thread and disband 
!$omp end parallel

!----------------------------------------------------------------------
      end program hello_world
!----------------------------------------------------------------------

