      program driver
!***********************************************************************
!     Test problems 3d for poisson equation
! 
!     3d poisson equation in Cartesian Coordinates
!     f = sin(4pi*x)*sin(4pi*y)*sin(4pi*z), rho = - 48*pi^2 f
!     x,y,z element of [0,1]
!     du = 1
!
!     n= m*m*m equations
!
!     Test for m x m x m matrix
!
!     Simon Scheidegger 11/16
!***********************************************************************

      use pardiso_module
      use prof_module

      implicit none

      integer, parameter :: m =  40  !m*m*m equations    
      integer :: n
      integer, allocatable :: ia(:)   !no eqs + 1
      integer, allocatable :: ja(:)
      real*8,  allocatable :: a(:)    !A matrix


      real*8,  allocatable :: b(:)    !Ax = b
      real*8,  allocatable :: x(:)    !Ax = b

      real*8, allocatable :: a_dum(:) 
      integer, allocatable :: ja_dum(:)
      integer :: i, index, nz, iter

!.....test data indices.................................................
      integer :: j, k
      real*8, allocatable :: rho(:,:,:), sol3d(:,:,:), Phi(:,:,:)
      real*8 :: h, xcoord, ycoord,zcoord
      real*8 :: boundary
      real*8, parameter :: pi = 3.141592653589793  

!=======================================================================
 
      call prof_initial

      n = m*m*m    !number of equations

!=======================================================================
!.....test data.........................................................
      allocate(sol3d(m,m,m),rho(m,m,m),Phi(m,m,m))
      allocate(b(n), x(n))

      boundary = 1

      h = 1./(m-1)
      iter = 1
      do k = 1, m
        do j = 1, m
          do i = 1, m
            xcoord = (i-1)*h
            ycoord = (j-1)*h
            zcoord = (k-1)*h

            rho(i,j,k) = sin(4*pi*xcoord)*sin(4*pi*ycoord)*sin(4*pi*zcoord) 
            b(iter) =  (h**2)*(-48*(pi**2.))*rho(i,j,k) 
            sol3d(i,j,k) = rho(i,j,k) + boundary

!.....boundary condition...............................................
           if (i .eq. 1) then
             b(iter) = b(iter) - boundary 
           endif
           if (j .eq. 1) then
              b(iter) = b(iter) - boundary 
           endif
           if (k .eq. 1) then
             b(iter) = b(iter) - boundary 
           endif
           if ( i .eq. m) then
             b(iter) = b(iter) - boundary 
           endif
           if ( j .eq. m) then
             b(iter) = b(iter) - boundary 
           endif
           if ( k .eq. m) then
             b(iter) = b(iter) - boundary 
           endif

           write(112,1030) iter, rho(i,j,k), b(iter),xcoord, &
     &     sin(4*pi*xcoord)*sin(4*pi*ycoord)*sin(4*pi*zcoord)
1030       format(I6,3X,ES12.5,5X,ES12.5,5X,ES12.5,5X,ES12.5)

           iter = iter + 1

           end do
        end do
      end do
!=======================================================================

!.....3D MATRIX, fill ia, ja, A.........................................
      allocate(ia(n+1))

!.....get indices.......................................................
      allocate(ja_dum(7*n+1),a_dum(7*n+1))
      call makematrix(m,n,ia,ja_dum,a_dum,nz)
      index = ia(n+1)

!.....fill proper array for the solver..................................
      allocate(ja(index-1),a(index-1))
      do i = 1 , index-1     
        ja(i) = ja_dum(i) 
        a(i) = a_dum(i)   
!        write(555,*) i, a(i), ja(i)   !debug
      end do

!=======================================================================

      call pardiso_init(n, a, ia, ja)

!.....solve the equation system 10x to see speedup      
      do i = 1, 10 
        call pardiso_solve(n, a, ia, ja, x, b)
      end do
!=======================================================================

!.....retransform 1D array of solution back to 3D Phi(i,j,k)............
      iter = 1
      do k = 1, m
        do j = 1, m
          do i = 1, m
            write(111,*) iter, b(iter), rho(i,j,k)
            Phi(i,j,k) =  x(iter)
            iter = iter + 1
          end do
        end do
      end do

      do j = 1, m
        do i = 1, m
          write(444,*) i,j, Phi(i,j,m/2)    !numerical solution
          write(445,*) i,j, sol3d(i,j,m/2)  !analyt. solution
        end do
        write(446,*) j, Phi(m/2,j,m/2)/sol3d(m/2,j,m/2)-1
      end do

!=======================================================================

      call pardiso_terminate(n, a, ia, ja)

!=======================================================================

      call prof_write(0)

!=======================================================================

      end program driver