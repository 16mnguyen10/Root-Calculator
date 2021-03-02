/*
************************************************************************************************************************************
Program name: "Root Calculator". This program calculates and display the roots (If there are any) of a quadratic                   *
 equation.         Copyright (C) 2021 Michael Nguyen.                                                                              *
                                                                                                                                   *
This file is part of the software program "Root Calculator".                                                                       *
Root Calculator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License       *
version 3 as published by the Free Software Foundation.                                                                            *
Quadratic is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied                    *
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.             *
A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                                    *
************************************************************************************************************************************



=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

 Author Information
   Author name: Michael Nguyen
   Author email: 16mnguyen10@gmail.com

 Program Information
   Program name: Root Calculator
   Programming Languages: Two modules in C++, one module in X86, one module in C
   Date program began:       2021-February-18
   Date program last update: 2021-February-28
   Date of reorganization of comments: 2021-February-28
   Files in this program: quadratic.asm isfloat.cpp quad_library.cpp second_degree.c
   Status: Finished.   The program was tested with no error

This file
   File name: quad_library.cpp
   Language: C++
   Assemble: g++ -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17
*/


#include <stdio.h>

extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

void show_no_root()
{
    printf("There are no available roots in this equation\n");
}

void show_one_root(double root)
{
    printf( "The root is %1.6lf\n", root );
}

void show_two_root(double root1, double root2)
{
    printf( "The roots are %1.6lf and %1.6lf.\n", root1, root2 );
}
