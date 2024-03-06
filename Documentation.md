# Register


|Name            |Description                                                                                  |
|----------------|---------------------------------------------------------------------------------------------|
|X               |A general-purpose register                                                                   |
|T               |A general-purpose register, which is also the target of TEST instructions (TEST, FJMP, TJMP) |
|M               |The global message register for inter-drone communication                                    |



# Instructions

The parameter variabel 'R' means any register.
The parameter variable 'N' means any integer.

General Syntax:
[OpCode] [param0] [param1] [param2] ...

|OpCode, Params  |Description                                                                                                   |
|----------------|--------------------------------------------------------------------------------------------------------------|
|Math            |                                                                                                              |
|----------------|--------------------------------------------------------------------------------------------------------------|
|COPY R/N R      |Copies value in param0 to the target register in param1                                                       |
|ADDI R/N R/N R  |Adds values in param0 and param1 and saves in target register in param2                                       |
|SUBI R/N R/N R  |Like ADDI but substracts instead                                                                              |
|MULI R/N R/N R  |Like ADDI but multiplication instead                                                                          |
|DIVI R/N R/N R  |Like ADDI but integer division instead                                                                        |
|MODI R/N R/N R  |Like ADDI but modulo operation instead                                                                        |
|----------------|--------------------------------------------------------------------------------------------------------------|
|Logic           |                                                                                                              |
|----------------|--------------------------------------------------------------------------------------------------------------|
|MARK Label      |Marks a line with a label that can be jumped to by jump-instructions                                          |
|JUMP Label      |Instruction pointer unconditionally jumps to the label in param0                                              |
|TJMP Label      |Jumps to label if value in T register is true (any value but 0)                                               |
|FJMP Label      |Jumps to label if value in T register is false (0)                                                            |
|TEST R/N LOP R/N|Tests param0 and param2 using the logical operator at LOP (can be =,<,>) and stores either true or false in T |
|----------------|--------------------------------------------------------------------------------------------------------------|
|Periphery       |                                                                                                              |
|----------------|--------------------------------------------------------------------------------------------------------------|
|MOVE            |Moves drone by one field towards currently looked-at direction                                                |
|TURN R/N        |Turns drone by 90 degrees either left (param0 negative) or right (param0 positive)                            |
