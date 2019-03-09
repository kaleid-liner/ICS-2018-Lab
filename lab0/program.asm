        .ORIG x3000
        AND R1, R0, #-2
        NOT R1, R1
        ADD R1, R1, #1
        LD R0, MIN
LOOP    ADD R0, R0, #1
        ADD R2, R0, R0
        ADD R3, R1, R2
        BRnp LOOP
        HALT
MIN     .FILL xBFFF
        .END
