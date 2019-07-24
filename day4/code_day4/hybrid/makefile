
### Fortran compiler wrapper
FC=mpif90

### CPP compiler wrapper
CXX=mpicxx

### Optimization flags
FFLAGS=-O3 -fopenmp

#######################################################################	

all: 1.hello_world_hybrid.exec 1a.hello_world_hybrid.exec
 
#######################################################################	

## Example 1
1.hello_world_hybrid.exec: 1.hello_world_hybrid.f90
	$(FC) $(FFLAGS) 1.hello_world_hybrid.f90 -o 1.hello_world_hybrid.exec

## Example 1a
1a.hello_world_hybrid.exec: 1a.hello_world_hybrid.cpp
	$(CXX) $(FFLAGS) 1a.hello_world_hybrid.cpp -o 1a.hello_world_hybrid.exec	
	

#######################################################################	

clean :
	rm -f *.exec

#######################################################################	
