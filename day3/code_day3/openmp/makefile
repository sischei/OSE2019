#######################################################################	

all: 	4.integration_pi.exec 4a.integration_pi.exec \
	4b.worksharing.f90.exec 4c.worksharing.cpp.exec 4d.work.exec\
	4e.work-print.exec 4f.work-static.exec 4g.work-dynamic.exec\
	5.vec_add_sections.exec 5a.vec_add_sections.exec \
	6.integration_pi_reduction.exec 6a.integration_pi_reduction.exec \
	dot_prod.exec normalize_vec.exec 

#######################################################################	


## Example 4
4.integration_pi.exec: 4.integration_pi.f90
	gfortran 4.integration_pi.f90 -fopenmp -o 4.integration_pi.exec

## Example 4a
4a.integration_pi.exec: 4a.integration_pi.cpp
	g++ 4a.integration_pi.cpp -fopenmp -o 4a.integration_pi.exec	
	
## Example 4b
4b.worksharing.f90.exec: 4b.worksharing.f90
	gfortran 4b.worksharing.f90 -fopenmp -o 4b.worksharing.f90.exec	
	
## Example 4c
4c.worksharing.cpp.exec: 4c.worksharing.cpp
	g++ 4c.worksharing.cpp -fopenmp -o 4c.worksharing.cpp.exec		
	
## Example 4d
4d.work.exec: 4d.work.cpp
	g++ 4d.work.cpp -fopenmp -o 4d.work.exec

## Example 4e
4e.work-print.exec: 4e.work-print.cpp
	g++ 4e.work-print.cpp -fopenmp -o 4e.work-print.exec	
	
## Example 4f
4f.work-static.exec: 4f.work-static.cpp
	g++ 4f.work-static.cpp -fopenmp -o 4f.work-static.exec		

## Example 4g
4g.work-dynamic.exec: 4g.work-dynamic.cpp
	g++ 4g.work-dynamic.cpp -fopenmp -o 4g.work-dynamic.exec		

## Example 5
5.vec_add_sections.exec: 5.vec_add_sections.f90
	gfortran 5.vec_add_sections.f90 -fopenmp -o 5.vec_add_sections.exec

## Example 5
5a.vec_add_sections.exec: 5a.vec_add_sections.cpp
	g++ 5a.vec_add_sections.cpp -fopenmp -o 5a.vec_add_sections.exec
	
## Example 6
6.integration_pi_reduction.exec: 6.integration_pi_reduction.f90
	gfortran 6.integration_pi_reduction.f90 -fopenmp -o 6.integration_pi_reduction.exec	

## Example 6
6a.integration_pi_reduction.exec: 6a.integration_pi_reduction.cpp
	g++ 6a.integration_pi_reduction.cpp -fopenmp -o 6a.integration_pi_reduction.exec	
	

#######################################################################	
## EXERCISE 1
normalize_vec.exec : normalize_vec.f90
	gfortran normalize_vec.f90 -fopenmp -o normalize_vec.exec

## EXERCISE 2
dot_prod.exec : dot_prod.f90
	gfortran dot_prod.f90 -fopenmp -o dot_prod.exec

#######################################################################	
	
clean :
	rm -f *.exec