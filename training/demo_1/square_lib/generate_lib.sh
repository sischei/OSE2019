
cd lib

g++ -c square.cpp 

ranlib libsquare.a

ar ruc libsquare.a square.o

ranlib libsquare.a

cd ..

g++ main.cpp -Ilib -Llib -lsquare