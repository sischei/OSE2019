### Fortran compiler wrapper
FC=gfortran

### CPP compiler wrapper
CXX=g++

### Optimization flags
FFLAGS= -O2

DFLAGS= -g -pg 


#######################################################################	

all: example_gprof.exec example_gprof_cpp.exec

#######################################################################	

## Example 1
example_gprof.exec: example_gprof.f90
	$(FC) $(FFLAGS) example_gprof.f90 $(DFLAGS) -o example_gprof.exec
	
#######################################################################	


#######################################################################	

## Example 2
example_gprof_cpp.exec: example_gprof.cpp
	$(CXX) $(FFLAGS) example_gprof.cpp $(DFLAGS) -o example_gprof_cpp.exec
	
#######################################################################	


clean :
	rm -f *.exec gmon.out

#######################################################################		