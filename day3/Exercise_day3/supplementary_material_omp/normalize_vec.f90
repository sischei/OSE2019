!----------------------------------------------------------------------   
      program normalize_vec
!----------------------------------------------------------------------   

      use omp_lib
      
      implicit none

      integer :: n = 40000000
      real(8), allocatable :: v(:)
      logical :: validated = .false.
      integer :: max_threads
      real(8) :: time_serial, time_parallel
   
!----------------------------------------------------------------------   
      allocate(v(n))
      
      call initialize(v, n)
      
      time_serial = -omp_get_wtime()
      
      call normalize_vector(v, n)
      
      time_serial = time_serial + omp_get_wtime()

!.....check the answer
      write(*,*) "serial error   : " , abs(norm(v, n) - 1.0d0)

      max_threads = omp_get_max_threads()
      
      call initialize(v, n)
      
      time_parallel = -omp_get_wtime()
      call normalize_vector_omp(v, N)
      
      time_parallel = time_parallel + omp_get_wtime()

!......check the answer
      write(*,*) 'parallel error : ', abs(norm(v,n) - 1.0d0)
      write(*,*) 'threads    : ', max_threads
      write(*,*) 'serial     : ', time_serial, ' seconds,\tparallel   : ', time_parallel, ' seconds'
      write(*,*) 'speedup    : ', time_serial/time_parallel
      write(*,*) 'efficiency : ', (time_serial/time_parallel)/max_threads

      deallocate(v)

!----------------------------------------------------------------------
            
      contains

!----------------------------------------------------------------------

!......function to compute the 2-norm of a vector v of length n
      real (8) function norm(v, n)
      
      implicit none
      
      integer, intent(in) :: n
      real(8), intent(out) :: v(n)
      integer :: i

      do i=1,n
        norm = norm + v(i)*v(i)
      end do

      norm = sqrt(norm)
      
      end function

!----------------------------------------------------------------------

! initialise v to values between -10 and 10
      subroutine initialize(v, n)

      implicit none
    
      integer,      intent(in) :: n
      real(8), intent(out) :: v(n)
      integer :: i

      do i=1,n
        v(i) = cos(1.0d0*i) * 10.
      end do
    
      end subroutine initialize

!----------------------------------------------------------------------

      subroutine normalize_vector(v, n)
      
      implicit none
      
      integer, intent(in) :: n
      real(8), intent(out) :: v(n)
      integer :: i
      real(8) :: norm = 0.0d0

!.....compute the norm of v
      do i=1,n
        norm = norm + v(i)*v(i);
      end do
      norm = sqrt(norm)

!.....normalize v
      do i=1,n
        v(i) = v(i) / norm
      end do
      
      end subroutine normalize_vector

!----------------------------------------------------------------------
      subroutine normalize_vector_omp(v, n)
      
      implicit none
    
      integer, intent(in) :: n
      real(8), intent(out) :: v(n)
      integer :: i
      real(8) :: norm = 0.0d0

!.....compute the norm of v
      do i=1,n
        norm = norm + v(i)*v(i);
      end do

      norm = sqrt(norm)

!.....normalize v
      do i=1,n
        v(i) = v(i) / norm
      end do
        
      end subroutine normalize_vector_omp
!----------------------------------------------------------------------

      
!----------------------------------------------------------------------
      end program normalize_vec
!----------------------------------------------------------------------


