# Copyright (C) 2010 Hans Pirnay
# All Rights Reserved.
# This file is distributed under the Eclipse Public License.


##########################################################################
#    You can modify this example makefile to fit for your own program.   #
#    Usually, you only need to change the five CHANGEME entries below.   #
##########################################################################

# CHANGEME: This should be the name of your executable
EXE = parametric_driver

# CHANGEME: Here is the name of all object files corresponding to the source
#           code that you wrote in order to define the problem statement
OBJS =  parametric_driver.o \
	parametricTNLP.o

# CHANGEME: Additional libraries
ADDLIBS =

# CHANGEME: Additional flags for compilation (e.g., include flags)
ADDINCFLAGS =

##########################################################################
#  Usually, you don't have to change anything below.  Note that if you   #
#  change certain compiler options, you might have to recompile Ipopt.   #
##########################################################################

# C++ Compiler command
CXX = g++

# C++ Compiler options
CXXFLAGS = -O3 -pipe -DNDEBUG -pedantic-errors -Wparentheses -Wreturn-type -Wcast-qual -Wall -Wpointer-arith -Wwrite-strings -Wconversion -Wno-unknown-pragmas -Wno-long-long   -DIPOPT_BUILD

# additional C++ Compiler options for linking
CXXLINKFLAGS =  -Wl,--rpath -Wl,/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib

SRCDIR = ../../../../../../Ipopt/contrib/sIPOPT/examples/parametric_cpp
ipoptsrcdir  = $(SRCDIR)/../../../../src
senssrcdir = $(SRCDIR)/../../src

# Include directories (we use the CYGPATH_W variables to allow compilation with Windows compilers)
#   we also need some Ipopt headers that are not installed, so we add $(ipoptsrcdir)/Algorithm and $(ipoptsrcdir)/LinAlg
INCL = `PKG_CONFIG_PATH=/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib64/pkgconfig:/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib/pkgconfig:/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/share/pkgconfig: pkg-config --cflags ipopt` -I`$(CYGPATH_W) $(ipoptsrcdir)/Algorithm` -I`$(CYGPATH_W) $(ipoptsrcdir)/LinAlg` -I`$(CYGPATH_W) $(senssrcdir)` $(ADDINCFLAGS)
#INCL = -I`$(CYGPATH_W) /home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/include/coin`  -I`$(CYGPATH_W) $(ipoptsrcdir)/Algorithm` -I`$(CYGPATH_W) $(ipoptsrcdir)/LinAlg` -I`$(CYGPATH_W) $(senssrcdir)` $(ADDINCFLAGS)

# Linker flags
LIBS = -lsipopt `PKG_CONFIG_PATH=/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib64/pkgconfig:/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib/pkgconfig:/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/share/pkgconfig: pkg-config --libs ipopt`
##LIBS = -link -libpath:`$(CYGPATH_W) /home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib` libsipopt.lib libipopt.lib -llapack -lblas -lm  -ldl
#LIBS = -L/home/simon/projects/OSM2018/day1_SparseGrid/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib -lsipopt -lipopt -llapack -lblas -lm  -ldl

# The following is necessary under cygwin, if native compilers are used
CYGPATH_W = echo

all: $(EXE)

.SUFFIXES: .cpp .c .o .obj

$(EXE): $(OBJS)
	bla=;\
	for file in $(OBJS); do bla="$$bla `$(CYGPATH_W) $$file`"; done; \
	$(CXX) $(CXXLINKFLAGS) $(CXXFLAGS) -o $@ $$bla $(LIBS) $(ADDLIBS)

clean:
	rm -rf $(EXE) $(OBJS)

.cpp.o:
	$(CXX) $(CXXFLAGS) $(INCL) -c -o $@ $<


.cpp.obj:
	$(CXX) $(CXXFLAGS) $(INCL) -c -o $@ `$(CYGPATH_W) '$<'`
