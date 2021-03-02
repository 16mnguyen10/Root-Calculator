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
   File name: second_degree.c
   Language: C
   Assemble: gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11
*/

// ===== Begin code area ================================================================================================
#include <stdio.h>

double quadratic();

int main(int argc, char* argv[])
{
    double output = 0.0;
    
    printf("Welcome to Root Calculator\nProgrammed by Michael Nguyen. Professional Programmer.\n\n");
    output = quadratic();
    printf("The main driver recevied %lf and has decided to keep it.\n", output);
    printf("Now a 0 will be return to the operating system. Have a nice day. Bye\n");
    
    return 0;
}
