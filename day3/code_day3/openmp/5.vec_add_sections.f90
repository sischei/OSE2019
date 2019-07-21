!======================================================================
!
!     Simple program demonstrating that different blocks of work 
!     will be done by different threads.
!
!     cf. https://computing.llnl.gov/tutorials/openMP/#SECTIONS
!
!======================================================================
      program vec_add_sections

      use omp_lib
      
      integer :: n, i
      parameter (n=10)
      real :: A(n), B(n), C(n), D(n)
      integer :: tid   !thread ID

!     Some initializations
      do i = 1, n
         A(i) = i * 1.5
         B(i) = i + 22.35
      end do

!$OMP PARALLEL SHARED(A,B,C,D), PRIVATE(I)

!$OMP SECTIONS
!.....fork 3 threads

!$OMP SECTION
      do i = 1, n
          C(i) = A(i) + B(i)
          write(*,*) 'Section 1: hello from thread ', omp_get_thread_num(), ' of ', omp_get_num_threads(), ' index ', i
      end do

!$OMP SECTION
      do i = 1, n
          D(i) = A(i) * B(i)
          write(*,*) 'Section 2: hello from thread ', omp_get_thread_num(), ' of ', omp_get_num_threads() ,' index ', i
      end do

!$OMP SECTION
      write(*,*) 'Section 3: hello from thread ', omp_get_thread_num(), ' of ', omp_get_num_threads() 
      write(*,*) 'This section 3 does nothing'      
      
      
!$OMP END SECTIONS NOWAIT

!$OMP END PARALLEL
!======================================================================
       end program vec_add_sections
!======================================================================
