.MODEL SMALL

.STACK 100H
.DATA
IS_NEG DB ?
FOR_PRINT DW ?
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF , '$'
i dw ?
j dw ?
k dw ?
l dw ?
m dw ?
n dw ?
o dw ?
p dw ?

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
SUB SP,44
; i=1;
MOV WORD PTR [bp-2],1
MOV CX,[bp-2]
MOV i,CX
; printf(i);
MOV AX,i
MOV FOR_PRINT,AX
CALL OUTPUT
; j=5+8;
MOV WORD PTR [bp-4],5
MOV AX,[bp-4]
MOV WORD PTR [bp-8],AX
MOV WORD PTR [bp-6],8
MOV AX,[bp-8]
ADD AX,[bp-6]
MOV WORD PTR [bp-10],AX
MOV CX,[bp-10]
MOV j,CX
; printf(j);
MOV AX,j
MOV FOR_PRINT,AX
CALL OUTPUT
; k=i+2*j;
MOV AX,i
MOV WORD PTR [bp-18],AX
MOV WORD PTR [bp-12],2
MOV CX,[bp-12]
MOV WORD PTR [bp-14],CX
MOV AX,CX
IMUL j
MOV WORD PTR [bp-16],AX
MOV AX,[bp-18]
ADD AX,[bp-16]
MOV WORD PTR [bp-20],AX
MOV CX,[bp-20]
MOV k,CX
; printf(k);
MOV AX,k
MOV FOR_PRINT,AX
CALL OUTPUT
; l=k/3;
MOV CX,k
CWD
MOV WORD PTR [bp-24],CX
MOV WORD PTR [bp-22],3
MOV CX,[bp-24]
MOV AX,CX
IDIV WORD PTR [bp-22]
MOV WORD PTR [bp-26],AX
MOV CX,[bp-26]
MOV l,CX
; printf(l);
MOV AX,l
MOV FOR_PRINT,AX
CALL OUTPUT
; m=k%9;
MOV CX,k
CWD
MOV WORD PTR [bp-30],CX
MOV WORD PTR [bp-28],9
MOV CX,[bp-30]
MOV AX,CX
IDIV WORD PTR [bp-28]
MOV WORD PTR [bp-32],DX
MOV CX,[bp-32]
MOV m,CX
; printf(m);
MOV AX,m
MOV FOR_PRINT,AX
CALL OUTPUT
; n=m<=l;
MOV AX,m
CMP AX,l
jle L0
MOV WORD PTR [bp-34],0
JMP L1
L0:
MOV WORD PTR [bp-34],1
L1:
MOV CX,[bp-34]
MOV n,CX
; printf(n);
MOV AX,n
MOV FOR_PRINT,AX
CALL OUTPUT
; o=i!=j;
MOV AX,i
CMP AX,j
jne L2
MOV WORD PTR [bp-36],0
JMP L3
L2:
MOV WORD PTR [bp-36],1
L3:
MOV CX,[bp-36]
MOV o,CX
; printf(o);
MOV AX,o
MOV FOR_PRINT,AX
CALL OUTPUT
; p=n||o;
CMP n,0
JNE L4
CMP o,0
JNE L4
MOV WORD PTR [bp-38],0
JMP L5
L4:
MOV WORD PTR [bp-38],1
L5:
MOV CX,[bp-38]
MOV p,CX
; printf(p);
MOV AX,p
MOV FOR_PRINT,AX
CALL OUTPUT
; p=n&&o;
CMP n,0
JE L6
CMP o,0
JE L6
MOV WORD PTR [bp-40],1
JMP L7
L6:
MOV WORD PTR [bp-40],0
L7:
MOV CX,[bp-40]
MOV p,CX
; printf(p);
MOV AX,p
MOV FOR_PRINT,AX
CALL OUTPUT
; p++;
MOV AX,p
MOV WORD PTR [bp-42],AX
INC p
; printf(p);
MOV AX,p
MOV FOR_PRINT,AX
CALL OUTPUT
; k=-p;
NEG WORD PTR [bp-]
MOV CX,-p
MOV k,CX
; printf(k);
MOV AX,k
MOV FOR_PRINT,AX
CALL OUTPUT
; return 0;
MOV WORD PTR [bp-44],0
MOV AX,[bp-44]
JMP L_main
L_main:
ADD SP,44
POP BP
;DOS EXIT
MOV AH,4ch
INT 21h
main ENDP
END MAIN
