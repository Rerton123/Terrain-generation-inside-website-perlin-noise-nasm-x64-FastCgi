mov rdi, cookieParm; isgauna POST, parametras = ka toky
mov rsi, [req + 32]
call FCGX_GetParam
test rax,rax
jz .no_token
mov esi,0
mov bl,[rax]
cmp bl,"T"
jne .TNot
    bts esi,1
.TNot

mov rdi,0
.ReadToken:
    mov bl,[rax]; session=abc123; theme=dark; user=bob
    cmp bl,0
    je .no_token
    cmp bl,59; jeigu dabartine raide = ';'
    jne .nn
        btr esi,0
        mov r9b,[rax+1]
        cmp r9b,"T"; jeigu sekanti raide = T
        jne .CheckSpace
            bts esi,1
            jmp .nn
        .CheckSpace:; Jeigu sekani raide = space
        cmp r9b," "
        jne .nn
            mov r9b,[rax+2]; Jeigu sekanti sekanti = T
            cmp r9b,"T"
            jne .nn
                bts esi,1

    .nn:
    cmp bl,'='
    jne .a1
        bt esi,1; jeigu skaito Token (cookie su pirma raide T)
        jnc .a1
            bts esi,0; Leidzia skaityti
            jmp .NV
    .a1:
    bt esi,0
    jnc .NV
        mov byte [Token + rdi],bl
        inc rdi
    .NV:
    
    inc rax
    jmp .ReadToken
.no_token:
