      program worksharing
!======================================================================
!
!     Simple vector-add program
!     Arrays A, B, C, and variable N will be shared by all threads.
!     Variable i will be private to each thread; each thread will have its own unique copy.
!     The iterations of the loop will be distributed dynamically in CHUNK sized pieces.
!     Threads will not synchronize upon completing their individual pieces of work (NOWAIT)      
!      
!======================================================================
      
      implicit none
      
      integer :: chunk, i
      integer, parameter :: n =1000
      integer, parameter :: chunksize = 100
      
      real :: A(n), B(n), C(n)

!.....Some initializations
      do i = 1, n
        A(i) = i * 1.0
        B(i) = A(i)
      end do
      chunk = chunksize
        
!$OMP PARALLEL SHARED(A,B,C,chunk) PRIVATE(i)

!$OMP DO SCHEDULE(DYNAMIC,chunk)
      do i = 1, n
        C(i) = A(I) + B(I)
      end do
!$OMP END DO NOWAIT

!$OMP END PARALLEL

!======================================================================
      end program worksharing
!======================================================================
