#PURPOSE:     This program finds the maximum number of a
#             set of data items
#
#
#VARIABLES:   The registers have the following uses:
#
#     %edi -  Holds the index of the data item being examined
#     %ebx -  Largest data item found
#     %eax -  Current data item
#
#             The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
#              to terminate the data

.section .data

data_items:
    .long 3,45,12,67,0,4,107,52,0    # 0 is the signal to finish the program. if it's been detected the items in the rest of the list will be ignored!
                                     # move the 0 from middle the list and the result will change from 67 to 107
.section .text

.global _start

_start:

    movl $0, %edi                   # move 0 into the index register
    movl data_items(,%edi,4), %eax  # load the first byte of data
    movl %eax, %ebx                 # since this is the first item, %eax is the biggest

loop_start:

    cmpl $0, %eax                   # check to see if we've hit the end
    je   loop_exit
    incl %edi                       # load the next value
    movl data_items(,%edi,4), %eax
    cmpl %eax , %ebx                # compare values
    jge  loop_start                 # jump to loop beginning if ebx is greater than or equal to eax
    movl %eax, %ebx                 # move the value as the largest
    jmp  loop_start                 # jump to loop beginning

loop_exit:

    # %ebx is the status code for the exit system call
    # %ebx already has the MAX value of the list

    movl $1, %eax                   # 1 is the exit() syscall
    int  $0x80


# to run this code in a linux machine,
# go to the directory and open a terminal ant type :
# $ as maximum.s -o maximum.o
# $ ld maximum.o -o maximum
# $ ./maximum
# $ echo $?
