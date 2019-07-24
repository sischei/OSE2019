      module pardiso_module
!=======================================================================
!
!     Module PARDISO, handles the Pardiso sparse matrix solver
!
!     Simon Scheidegger, 08/16
!
!=======================================================================

      use prof_module

      implicit none

      integer, public, dimension(64)  :: iparm
      real*8,  public, dimension(64)  :: dparm(64)
      integer*8,public   :: pt(64)
      integer, public    :: maxfct
      integer, public    :: mnum
      integer, public    :: mtype
      integer, public    :: phase
      integer, public    :: nrhs
      integer, public    :: msglvl
      integer, public    :: solver
      integer, public    :: error
      real*8,  public    :: ddum
      integer, public    :: idum

      contains


!=======================================================================
!
!     this subroutine is called at the beginning of the program
!     and initializes PARDISO parameters
!
!=======================================================================
      subroutine pardiso_init(n, a, ia, ja)
      use prof_module


      implicit none

      integer    :: omp_get_max_threads, i
      external   :: omp_get_max_threads

      integer, intent(in)     :: n
      real*8, dimension(*), intent(in)    :: a
      integer, dimension(*), intent(in)   :: ia
      integer, dimension(*), intent(in)   :: ja


!.....set sover........................................................
      solver    =  0      ! use sparse direct method

!.....set number of factors with identical sparsity structure...........
      maxfct = 1

!.....number of matrix for the solution phase 1<= mnum <= maxfct........
      mnum = 1

!.....define matrix type................................................
      mtype     = -2      ! symmetric matrix

!.....number of right-hand sides........................................
      nrhs = 1

!.....message level information........................................
!      msglvl = 0

!  .. PARDISO license check and initialize solver
      call pardisoinit(pt, mtype, solver, iparm, dparm, error)
      IF (error .NE. 0) THEN
        IF (error.EQ.-10 ) WRITE(*,*) 'No license file found'
        IF (error.EQ.-11 ) WRITE(*,*) 'License is expired'
        IF (error.EQ.-12 ) WRITE(*,*) 'Wrong username or hostname'
        STOP
      ELSE
        WRITE(*,*) 'PARDISO license check was successful ... '
      END IF

      
!  .. Numbers of Processors ( value of OMP_NUM_THREADS )
      iparm(3) = omp_get_max_threads()  !number of processors      
      write(*,*) 'PARDISO launched with',iparm(3), 'Threads'


      iparm(1)  = 1
      iparm(8) =  2      ! refinement
      iparm(29) = 0      !1: 32-bit precision, 0: 64-bit precision
 
      iparm(32) = 0    ! use multirecursive iterative solver
      dparm(1) = 300  !  Max Iteration in krylov-Subspace Iteration
      dparm(2) = 1.d-6 !1d-6 !  Relative Residual Tolerance for Convergencd
      dparm(3) = 5000 !  Size of Coarse Grid Matrix
      dparm(4) = 10   !  Maximum Number of Levels in Grid Hierachy
      dparm(5) = 1d-3 !  Dropping Threshold for Incomplete Factor
      dparm(6) = 1d-3 !  Dropping Threshold for Schurcomplement
      dparm(7) = 10   !  Max number of Fill-in for each column in the factor
      dparm(8) = 500  !  Bound for the Norm of the Inverse of L
      dparm(9) = 25   !  Maximum stagnation steps in the solver

!debug
!      do i = 1, index - 1 
!        write(666,*)i, a(i), ja(i)
!      end do


      phase     = 11      ! only reordering and symbolic factorization
      msglvl    = 2       ! with statistical information

      call prof_enter(25,'re-ordering')

      call pardiso (pt, maxfct, mnum, mtype, phase, n, a, ia, ja, &
     &              idum, nrhs, iparm, msglvl, ddum, ddum, error,dparm)

      call prof_exit(25)   

      write(*,*) 'Reordering completed ... '

      if (error .ne. 0) then
        WRITE(*,*) 'The following ERROR was detected: ', error
        stop
      end if

      write(*,*) 'Number of nonzeros in factors   = ',iparm(18)
      write(*,*) 'Number of factorization MFLOPS  = ',iparm(19)

!.....Factorization......................................................
      phase     = 22  ! only factorization

      call prof_enter(26,'factorization')

      call pardiso (pt, maxfct, mnum, mtype, phase, n, a, ia, ja, &
     &              idum, nrhs, iparm, msglvl, ddum, ddum, error,dparm) 

      call prof_exit(26)

      write(*,*) 'Factorization completed ...  '
      if (error .NE. 0) then
         write(*,*) 'The following ERROR was detected: ', error
        stop
      end if 

      end subroutine pardiso_init


!=======================================================================
!
!     this subroutine is called at the end of the program
!     and teminates PARDISO
!
!=======================================================================
      subroutine pardiso_solve(n, a, ia, ja, x, b)
!      subroutine pardiso_solve(n, a, ia, ja, b)

      integer, intent(in)                 :: n
      real*8, dimension(*), intent(in)    :: a
      integer, dimension(*), intent(in)   :: ia
      integer, dimension(*), intent(in)   :: ja
      real*8, dimension(*), intent(in)    :: b
      real*8, dimension(*), intent(out)   :: x


      phase     = 33  ! only solve
      iparm(8)  = 2  !1 ! max numbers of iterative refinement steps

      call prof_enter(5,'1. solve Ax=b')
      call pardiso (pt, maxfct, mnum, mtype, phase, n, a, ia, ja,&
     &              idum, nrhs, iparm, msglvl, b, x, error, dparm)
      call prof_exit(5)
      write(*,*) 'Solve completed ... '

      end subroutine pardiso_solve


!=======================================================================
!
!     this subroutine is called at the end of the program
!     and teminates PARDISO
!
!=======================================================================
      subroutine pardiso_terminate(n, a, ia, ja)

      implicit none

      integer, intent(in)     :: n
      real*8, dimension(*), intent(in)    :: a
      integer, dimension(*), intent(in)   :: ia
      integer, dimension(*), intent(in)   :: ja

!.....Termination and release of memory.................................
      phase     = -1           ! release internal memory
      call pardiso (pt, maxfct, mnum, mtype, phase, n, ddum, idum, idum, &
     &              idum, nrhs, iparm, msglvl, ddum, ddum, error, dparm)

      write(*,*) 'Pardiso terminated, memory released...'

      return

      end subroutine pardiso_terminate

!=======================================================================

      end module pardiso_module