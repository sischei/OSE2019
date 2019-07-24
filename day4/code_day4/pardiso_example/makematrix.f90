      subroutine makematrix(m,n,ia,ja,a,nz)
!***********************************************************************
!     Routine which fills A, Ja, Ia for PARDISO solver
!
!     in a symmetric way, i.e. only upper triangle
!
!     Simon Scheidegger, 08/16!
!***********************************************************************
      implicit none

      integer y,ni,i,j,k,ElementsPut,n,m,nz
      integer :: ia(0:N),ja(0:7*N)
      real*8 ::a(0:7*N) 
      real*8 :: bb
      integer :: nn(0:6)

!.......................................................................      
      call srand(0)

      ElementsPut=0

!.......................................................................            
      do i=0,N
         ia(i) = 0
      enddo
!.......................................................................      
      ia(0) = 1
!.......................................................................      
      do k=0,M-1
       do j=0,M-1
        do i=0,M-1
         y=i+j*M+k*M*M
         nn(0)=y
         nn(1)=mod(i+1,M)+j*M+k*M*M
         nn(2)=i+mod(j+1,M)*M+k*M*M
         nn(3)=i+j*M+mod(k+1,M)*M*M
         nn(4)=i+j*M+mod(k+M-1,M)*M*M !  -> diagonale links unten
         nn(5)=i+mod(j+M-1,M)*M+k*M*M !  -> linke off-diagonale
         nn(6)=mod(M+i-1,M)+j*M+k*M*M !  -> links neben diagonale

         ElementsPut=ElementsPut+1
         ja(ElementsPut-1)=nn(0)+1
         a(ElementsPut-1)=-6.0

         do ni=1,3
          if(nn(ni).gt.y)then
           ElementsPut=ElementsPut+1
           ja(ElementsPut-1)=nn(ni)+1
           a(ElementsPut-1)=1.0
          endif
         enddo

         ia(y+1)=ElementsPut+1

        enddo
       enddo
      enddo
!.......................................................................      

      ia(N)=ElementsPut+ia(0)
      nz=ElementsPut
      
      return
!=======================================================================      
      end subroutine
!=======================================================================
