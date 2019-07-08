cmake_minimum_required(VERSION 2.8)
 
project(PT2017)

# compile the programs from sourse
add_executable(loop loop.cpp)
add_executable(swap swapfixed.cpp)
# add_executable(swap0 swap.cpp) # won t work because of swap3 ;-)

