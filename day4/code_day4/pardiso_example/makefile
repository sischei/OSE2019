
############################################################################
LDLIBS=

FLIBS = lib/libpardiso500-GNU481-X86-64.so -llapack -lblas -fopenmp -lpthread -lm

############################################################################

#GFORTRAN
FC = gfortran -g -c                   #compile
LK = gfortran -o test             #link
SF = -fdefault-real-8    #compile flags -mcmodel=medium -xW
CF = -fopenmp -lpthread -lm
############################################################################


OBJS =\
  driver.o\
  makematrix.o\
  pardiso_module.o\
  prof_module.o\

test:\
  $(OBJS); $(LK) $(CF) $(OBJS) $(LDLIBS) $(FLIBS)

makematrix.o:\
  makematrix.f90; $(FC) $(CF) $(@:.o=.f90)

driver.o:\
  pardiso_module.o\
  prof_module.o\
  driver.f90; $(FC) $(CF) $(@:.o=.f90)

pardiso_module.o:\
  prof_module.o\
  pardiso_module.f90; $(FC) $(CF) $(@:.o=.f90)

prof_module.o:\
  prof_module.f; $(FC) $(CF) $(@:.o=.f)

########################################################################
clean:
	rm -vf *.mod *.o  test fort.* profile_*.dat
