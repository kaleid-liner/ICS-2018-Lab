; ===========================
; FileName: lab2.asm
; Author  : wjy       
; StuNo.  : PB17111586
; ===========================
; 
; Calling Convention:
; - RTL
; - first four parameters passed 
;   in registers R0-R3
; - call functions by JSR
; - function Prologue
;   ```
;   PUSH R7
;   ```
; - function Epilogue
;   ```
;   POP R7
;   RET
;   ```
; - Caller clear-up
; - Return value in R0, if any
; - Caller-saved registers: R0-R4
; - Callee-saved registers: R5-R7
; - R6 as Top of stack pointer
; - local variables in stack

        .ORIG x3000

        ; C Runtime
        LD R6, ebp
        JSR main
        HALT

ebp     .FILL xFDFF

main    ADD R6, R6, #-1
        STR R7, R6, #0
        GETC
        LD R1, m_zero
        ADD R0, R0, R1
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        ADD R6, R6, #-3
        AND R4, R4, #0
        STR R4, R6, #2
        STR R4, R6, #1
        STR R0, R6, #0
        AND R0, R0, #0
        JSR func
        LDR R7, R6, #0
        ADD R6, R6, #1
        RET

m_zero  .FILL xFFD0

func    ADD R6, R6, #-1
        STR R7, R6, #0
; NOTE: the order of evaluation isn't defined
        ADD R6, R6, #-7; f,e,d,c,t,x,y
        STR R0, R6, #6 ; f
        STR R1, R6, #5 ; e
        STR R2, R6, #4 ; d
        STR R3, R6, #3 ; c
        ADD R1, R1, R0
        ADD R1, R1, R2
        ADD R1, R1, R3 ; f+e+d+c
        LDR R0, R6, #10; b
        ADD R1, R1, R0
        LDR R0, R6, #9 ; a
        ADD R1, R1, R0 ; a+b+c+d+e+f
        GETC
        ADD R1, R1, R0
        LD R0, f_zero
        ADD R1, R1, R0  
        LDR R0, R6, #8 ; n
        ADD R4, R0, #-1
        BRnz rett

        ; if n > 1
        STR R1, R6, #2 ; t
        LDR R0, R6, #6
        LDR R1, R6, #5
        LDR R0, R6, #10; b
        ADD R6, R6, #-3
        STR R0, R6, #2
        LDR R0, R6, #12; a
        STR R0, R6, #1
        STR R4, R6, #0        ; n - 1
        JSR func
        ADD R6, R6, #3 
        STR R0, R6, #1 ; x

        LDR R4, R6, #8
        ADD R4, R4, #-2
        LDR R0, R6, #6
        LDR R1, R6, #5
        LDR R2, R6, #4
        LDR R3, R6, #3
        LDR R0, R6, #10; b
        ADD R6, R6, #-3
        STR R0, R6, #2
        LDR R0, R6, #12; a
        STR R0, R6, #1
        STR R4, R6, #0        ; n - 2
        JSR func
        ADD R6, R6, #3

        LDR R1, R6, #2 
        ADD R0, R0, R1 ; t
        LDR R1, R6, #1 ; x
        ADD R0, R0, R1 ; x + y + t
        ADD R0, R0, #-1
        ADD R6, R6, #7
        LDR R7, R6, #0
        ADD R6, R6, #1
        RET

rett    ADD R0, R1, #0 
        ADD R6, R6, #7
        LDR R7, R6, #0
        ADD R6, R6, #1
        RET

f_zero  .FILL xFFD0

        .END
