###########################################
## IF compiler changes, change BASHRC!!!##
##########################################


############################################################################
# phys-nova-12 with pardiso sparse matrix solver and gfortran

#LDLIBS= -L /home/simon/projects/pardiso/gfortran_64/ -L /usr/lib/

#LDLIBS= -L lib/ -L /usr/lib/
LDLIBS=

FLIBS = lib/libpardiso500-GNU481-X86-64.so -llapack -lblas -fopenmp -lpthread -lm
#to compile with intel MKL uncomment the following line
#FLIBS = lib/libpardiso500-GNU481-X86-64.so -lmkl_rt -fopenmp -lpthread -lm

############################################################################

#ifort with intel libs
# LDLIBS= -L /home/simon/projects/pardiso/intel_64 \
#         -L /opt/intel/composer_xe_2013_sp1.1.106/mkl/lib/intel64 \
#         -I/opt/intel/composer_xe_2013_sp1.1.106/mkl/include

# FLIBS =	-lpardiso412-INTEL120-X86-64 -lmkl_intel_lp64  -lmkl_sequential \
# 	-lmkl_core -lpthread -lpthread -lgomp -liomp5 -lmkl_gnu_thread -lgfortran -llapack


#crappy flags
#FLIBS = -libpardiso412-INTEL120-X86-64 -lgomp -lmkl -lguide -lpthread \
#        -liomp5 -lmkl_gnu_thread -lgfortran -lmkl_lapack \
#        -lmkl_em64t -lmkl_core -lguide -lpthread
#```````````````````````````````

############################################################################
############################################################################
#GFORTRAN
FC = gfortran -g -c                   #compile
LK = gfortran -o test             #link
SF = -fdefault-real-8    #compile flags -mcmodel=medium -xW
CF = -fopenmp -lpthread -lm
############################################################################

#IFORT
# FC = ifort -O3 -c                   #compile
# LK = ifort -o test             #link
# SF = -r8 -module   #compile flags -mcmodel=medium -xW
# CF = -openmp -traceback

###########################################################################



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
