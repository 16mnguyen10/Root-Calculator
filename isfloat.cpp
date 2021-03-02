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
   File name: quadratic.asm
   Language: C++
   Assemble: g++ -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp  -std=c++17
*/

#include <iostream>
#include <cstdlib>
#include <ctype.h>

extern "C" bool isfloat(char [ ]);

bool isfloat(char x[ ])
{   
    bool result = true;
    bool temp = false;
    int start = 0;
    
    if (x[0] == '-' || x[0] == '+') start = 1;
    
    unsigned long int i = start;

    while (!(x[i] == '\0') && result )
    {
        if (x[i] == '.' && !temp) 
        {
            temp = true;
        }
        else
        {
            result = result && isdigit(x[i]); 
        }
        i++;
    }
    
    return result && temp;
}