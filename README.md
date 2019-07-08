### Introduction to sparse grids and parallel programming in economics and finance

This is a introductory course on adaptive sparse grids and parallel programming, held at the 
Open Source Macroeconomics Laboratory Bootcamp (BFI, University of Chicago) July and August 2019.
* [OSE Bootcamp 2019](https://github.com/OpenSourceEcon/BootCamp2019) 


**Prerequisites:** Students should have prior knowledge in a programming language (a low-leve language such as C++, C, Fortran would be beneficial, but is not required). Moreover, there should be interest in accessing parallel compute resources due to research projects that require non-trivial numerical methods. Students are encouraged to bring their own research projects to be discussed.  

### Purpose of the lecture

Parallel computation has, next to theory and experiments, become in many fields a well-established and recognized third pillar of science within the last couple of years. 
The emerging computing power available to researchers nowadays reaches up to hundreds of Petaflop/s,
which is several million times faster than an average laptop. 
This allows for computer-aided discoveries that would otherwise be impossible. Also in modern quantitative economics and 
finance, parallel computing has become a key workhorse. Indeed, processing for example enormous sets of data in a timely 
fashion is only possible through massive parallel computing resources. 
Moreover, many relevant applications in quantitative finance, such as the computation of 
large portfolio risks or the pricing of complex financial derivative products, are heavily accelerated by means of appropriate hardware. 

However, tapping parallel hardware resources efficiently is challenging. Indeed, 
for the greater part of computer history software has been written with a serial von
Neumann computer architecture in mind, in which a computer program -- in whatever programming language it is written -- 
is ultimately translated into a stream of instructions that are executed sequentially. 
Parallel programming is fundamentally different. A key task of the software developer is 
to identify parts of an algorithm that can be run concurrently or to transform a 
given serial algorithm into an algorithm suitable for concurrent execution.

This course is intended to provide students in economics and finance with a self-contained 
introduction to the extensive and broad topic of parallel computing, with a special 
focus on relevant applications. Topics covered include shared memory, distributed memory, 
hybrid parallel programming software developement, and the good scientific conduct necessary to deal
with the results from numerical applications. 
A key part of the course is devoted to hands-on labs based on 
smaller exercises as well as larger projects. 
### Lecturer
* [Simon Scheidegger](https://sites.google.com/site/simonscheidegger/) (HEC University of Lausanne)


**Date** | **Time** | **Main Topics** 
-----|------|------
07.16.2018 | 08:00 - 12:00 | Introduction to Adaptive Sparse Grids
07.18.2018 | 08:00 - 12:00 | Introduction to HPC and OpenMP
07.23.2018 | 08:00 - 12:00 | Introduction to OpenMP II and MPI
07.15.2017 | 08:00 - 12:00 | Introduction to Hybrid parallelism




**Anyone is free to use this teaching material. In the latter case, a reference to this repository would however be expected**





