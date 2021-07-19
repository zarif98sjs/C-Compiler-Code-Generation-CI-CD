.MODEL SMALL

.STACK 100H
.DATA
IS_NEG DB ?
FOR_PRINT DW ?
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF , '$'

.CODE

OUTPUT PROC
               
        MOV CX , 0FH     
        PUSH CX ; marker
        
        MOV IS_NEG, 0H
        MOV AX , FOR_PRINT
        TEST AX , 8000H
        JE OUTPUT_LOOP
                    
        MOV IS_NEG, 1H
        MOV AX , 0FFFFH
        SUB AX , FOR_PRINT
        ADD AX , 1H
        MOV FOR_PRINT , AX

    OUTPUT_LOOP:
    
        ;MOV AH, 1
        ;INT 21H
        
        MOV AX , FOR_PRINT
        XOR DX,DX
        MOV BX , 10D
        DIV BX ; QUOTIENT : AX  , REMAINDER : DX     
        
        MOV FOR_PRINT , AX
        
        PUSH DX
        
        CMP AX , 0H
        JNE OUTPUT_LOOP
        
        ;LEA DX, NEWLINE ; DX : USED IN IO and MUL,DIV
        ;MOV AH, 9 ; AH,9 used for character string output
        ;INT 21H;

        MOV AL , IS_NEG
        CMP AL , 1H
        JNE OP_STACK_PRINT
        
        MOV AH, 2
        MOV DX, '-' ; stored in DL for display 
        INT 21H
            
        
    OP_STACK_PRINT:
    
        ;MOV AH, 1
        ;INT 21H
    
        POP BX
        
        CMP BX , 0FH
        JE EXIT_OUTPUT
        
       
        MOV AH, 2
        MOV DX, BX ; stored in DL for display 
        ADD DX , 30H
        INT 21H
        
        JMP OP_STACK_PRINT

    EXIT_OUTPUT:
    
        ;POP CX 

        LEA DX, NEWLINE
        MOV AH, 9 
        INT 21H
    
        RET     
      
OUTPUT ENDP

main PROC
MOV AX, @DATA
MOV DS, AX
PUSH BP
MOV BP,SP
SUB SP,60

; i=1;
MOV WORD PTR [bp-18],1
MOV CX,[bp-18]
MOV WORD PTR [bp-2],CX

; printf(i);
MOV AX,[bp-2]
MOV FOR_PRINT,AX
CALL OUTPUT
; j=5+8;
MOV WORD PTR [bp-20],5
MOV AX,[bp-20]
MOV WORD PTR [bp-24],AX
MOV WORD PTR [bp-22],8
MOV AX,[bp-24]
ADD AX,[bp-22]
MOV WORD PTR [bp-26],AX
MOV CX,[bp-26]
MOV WORD PTR [bp-4],CX

; printf(j);
MOV AX,[bp-4]
MOV FOR_PRINT,AX
CALL OUTPUT
; k=i+2*j;

MOV AX,[bp-2]
MOV WORD PTR [bp-34],AX
MOV WORD PTR [bp-28],2
MOV CX,[bp-28]
MOV WORD PTR [bp-30],CX

MOV CX,[bp-30]
MOV AX,CX
IMUL WORD PTR [bp-4]
MOV WORD PTR [bp-32],AX
MOV AX,[bp-34]
ADD AX,[bp-32]
MOV WORD PTR [bp-36],AX
MOV CX,[bp-36]
MOV WORD PTR [bp-6],CX

; printf(k);
MOV AX,[bp-6]
MOV FOR_PRINT,AX
CALL OUTPUT
; l=k/3;

MOV CX,[bp-6]
CWD
MOV WORD PTR [bp-40],CX
MOV WORD PTR [bp-38],3
MOV CX,[bp-40]
MOV AX,CX
IDIV WORD PTR [bp-38]
MOV WORD PTR [bp-42],AX
MOV CX,[bp-42]
MOV WORD PTR [bp-8],CX

; printf(l);
MOV AX,[bp-8]
MOV FOR_PRINT,AX
CALL OUTPUT
; m=k%9;

MOV CX,[bp-6]
CWD
MOV WORD PTR [bp-46],CX
MOV WORD PTR [bp-44],9
MOV CX,[bp-46]
MOV AX,CX
IDIV WORD PTR [bp-44]
MOV WORD PTR [bp-48],DX
MOV CX,[bp-48]
MOV WORD PTR [bp-10],CX

; printf(m);
MOV AX,[bp-10]
MOV FOR_PRINT,AX
CALL OUTPUT
; n=m<=l;


MOV AX,[bp-10]
CMP AX,[bp-8]
jle L0
MOV WORD PTR [bp-50],0
JMP L1
L0:
MOV WORD PTR [bp-50],1
L1:

MOV CX,[bp-50]
MOV WORD PTR [bp-12],CX

; printf(n);
MOV AX,[bp-12]
MOV FOR_PRINT,AX
CALL OUTPUT
; o=i!=j;


MOV AX,[bp-2]
CMP AX,[bp-4]
jne L2
MOV WORD PTR [bp-52],0
JMP L3
L2:
MOV WORD PTR [bp-52],1
L3:

MOV CX,[bp-52]
MOV WORD PTR [bp-14],CX

; printf(o);
MOV AX,[bp-14]
MOV FOR_PRINT,AX
CALL OUTPUT
; p=n||o;


CMP [bp-12],0
JNE L4
CMP [bp-14],0
JNE L4
MOV WORD PTR [bp-54],0
JMP L5
L4:
MOV WORD PTR [bp-54],1
L5:

MOV CX,[bp-54]
MOV WORD PTR [bp-16],CX

; printf(p);
MOV AX,[bp-16]
MOV FOR_PRINT,AX
CALL OUTPUT
; p=n&&o;


CMP [bp-12],0
JE L6
CMP [bp-14],0
JE L6
MOV WORD PTR [bp-56],1
JMP L7
L6:
MOV WORD PTR [bp-56],0
L7:

MOV CX,[bp-56]
MOV WORD PTR [bp-16],CX

; printf(p);
MOV AX,[bp-16]
MOV FOR_PRINT,AX
CALL OUTPUT
; p++;

MOV AX,[bp-16]
MOV WORD PTR [bp-58],AX
INC WORD PTR [bp-16]

; printf(p);
MOV AX,[bp-16]
MOV FOR_PRINT,AX
CALL OUTPUT
; k=-p;

NEG WORD PTR [bp-16]
MOV CX,[bp-16]
MOV WORD PTR [bp-6],CX

; printf(k);
MOV AX,[bp-6]
MOV FOR_PRINT,AX
CALL OUTPUT
; return 0;
MOV WORD PTR [bp-60],0
MOV AX,[bp-60]
JMP L_main

L_main:
ADD SP,60
POP BP

;DOS EXIT
MOV AH,4ch
INT 21h
main ENDP
END MAIN


