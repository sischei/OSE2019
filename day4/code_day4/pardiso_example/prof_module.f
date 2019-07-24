!***********************************************************************
!
!     Module to help rough code profiling
!     CITA, Matthias Liebendoerfer, 2003
!
!***********************************************************************

      module prof_module

      implicit none

      integer, parameter :: prof_n=100 !maximum number of intervals
      logical, dimension(prof_n) :: prof_on !true during time measure
      character(len=24), dimension(prof_n) :: prof_l !legend
      integer, dimension(prof_n) :: prof_c !counts interval entries
      real, dimension(prof_n) :: prof_t0 !stores time of entry
      real, dimension(prof_n) :: prof_t !accumulates interval cpu time

      contains

!=======================================================================
!
!     this subroutine is called at the beginning of the program
!
!=======================================================================

      subroutine prof_initial

      real :: dummy

      call cpu_time(dummy)
      prof_on = .false.
      prof_l = ' '
      prof_c = 0
      prof_t = 0.
      call prof_enter(prof_n,'total')

      end subroutine prof_initial
     
!=======================================================================
!
!     this subroutine is called at the beginning of an interval 'i'
!
!=======================================================================

      subroutine prof_enter(i,leg)

      integer, intent(in) :: i
      character(len=*) :: leg

      prof_on(i) = .true.
      prof_l(i) = leg
      prof_c(i) = prof_c(i)+1
      call cpu_time(prof_t0(i))

      end subroutine prof_enter

!=======================================================================
!
!     this subroutine is called at the end of an interval 'i'
!
!=======================================================================

      subroutine prof_exit(i)

      integer, intent(in) :: i
      real :: t1

      if (prof_on(i)) then
        call cpu_time(t1)
        prof_t(i) = prof_t(i)+t1-prof_t0(i)
        prof_t0(i) = t1
      endif
      prof_on(i) = .false.

      end subroutine prof_exit

!=======================================================================
!
!     this subroutine is used to dump the profiling into a file
!
!=======================================================================

      subroutine prof_write(mr)

      integer, intent(in) :: mr !rank in parallel environment

!-----------------------------------------------------------------------

      character(len=16) :: filename
      integer :: i

!.....creat filename that reflects rank of process......................
      write(filename,44) mr
44    format('profile_',i4,'.dat')
      do i=1,14
        if (filename(i:i).eq.' ') filename(i:i)='0'
      enddo
      open(1,file=trim(filename),status='unknown')

      write(1,11)
11    format(72('-'))
      write(1,22) 'interval','count','average','total','in percent'
22    format(a24,4a12)
      write(1,11)
      do i=1,prof_n
        if (prof_on(i)) then
          call prof_exit(i)
          prof_on(i) = .true.
        endif
      enddo
      do i=1,prof_n
        if (prof_c(i).gt.0) then
          write(1,33) prof_l(i),prof_c(i),prof_t(i)/float(prof_c(i)),
     1      prof_t(i),100.*prof_t(i)/prof_t(prof_n)
        endif
      enddo
33    format(a24,i12,2g12.4,f12.4)
      write(1,11)

      close(1)
      
      end subroutine prof_write

!=======================================================================

      end module prof_module

!***********************************************************************
