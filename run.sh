#!bin/bash

#Program: Root Calculator
#Author: Michael Nguyen

echo "Delete some un-needed files"
rm *.o
rm *.out

echo "Compile second_degree.c"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11

echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "Compile isfloat.cpp using the gcc compiler standard 2017"
g++ -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp  -std=c++17

echo "Compile quad_library.cpp"
g++ -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17

echo "Link the object files using the gcc linker standard 2017"
g++ -m64 -no-pie -o Assignment2_Quadratic.out -std=c++17 quadratic.o second_degree.o isfloat.o quad_library.o

echo "Run the program Root Calculator:"
./Assignment2_Quadratic.out

echo "The script file will terminate"