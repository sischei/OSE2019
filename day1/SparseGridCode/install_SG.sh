# Install entire sparse grid libraries, IPOPT and PYIPOT at once

# make matlab available 
module load matlab

# unpack Matlab sparse grid library
unzip spinterp_v5.1.1.zip
echo " SPINTERP is unpacked "

# unpack and compile Tasmanian Sparse grid library, and test python example
unzip TasmanianSparseGrids.zip
cd TasmanianSparseGrids
make
# cd InterfacePython
# python example.py  ##test
echo " Tasmanian library is installed "

# Install IPOPT and PYIPOPT
cd ../
cd pyipopt_midway
./install_midway.sh
echo " IPOPT and PYIPOPT is installed "

cd
pwd=`pwd`
echo 'module load python' >> ~/.bashrc 
echo 'export LD_LIBRARY_PATH='$PREFIX'/lib:'$LD_LIBRARY_PATH >> ~/.bashrc 
echo 'export IPOPT_DIR="'$pwd'/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build"' >> ~/.bashrc 
echo 'export LD_LIBRARY_PATH='$IPOPT_DIR'/lib:'$LD_LIBRARY_PATH >> ~/.bashrc 