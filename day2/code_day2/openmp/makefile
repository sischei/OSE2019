#######################################################################	

all: 1.hello_world.exec 1a.hello_world.exec 2.racing_cond.exec 2.racing_cond.exec\
	3.racing_cond_fix.exec 3a.racing_cond_fix.exec 

#######################################################################	

## Example 1
1.hello_world.exec : 1.hello_world.f90
	gfortran 1.hello_world.f90 -fopenmp -o 1.hello_world.exec

## Example 1a
1a.hello_world.exec : 1a.hello_world.cpp
	g++ 1a.hello_world.cpp -fopenmp -o 1a.hello_world.exec	
	
## Example 2
2.racing_cond.exec : 2.racing_cond.f90
	gfortran 2.racing_cond.f90 -fopenmp -o 2.racing_cond.exec	

## Example 2a
2a.racing_cond.exec : 2a.racing_cond.cpp
	g++ 2.racing_cond.cpp -fopenmp -o 2a.racing_cond.exec	
	
## Example 3
3.racing_cond_fix.exec : 3.racing_cond_fix.f90
	gfortran 3.racing_cond_fix.f90 -fopenmp -o 3.racing_cond_fix.exec	

## Example 3a
3a.racing_cond_fix.exec : 3a.racing_cond_fix.cpp
	g++ 3a.racing_cond_fix.cpp -fopenmp -o 3a.racing_cond_fix.exec	


#######################################################################	
	
clean :
	rm -f *.exec
	
#######################################################################	
