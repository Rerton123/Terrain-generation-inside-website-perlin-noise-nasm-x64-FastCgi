

Str2NumWithTerm

cmp rsi,37
ja .P_end

push rsi
lea rdi, [postbuf]
mov rdx, [req + 8]
call FCGX_GetStr; returns postbuf
; mov rcx,rax


; mov rdx,10
; mov rsi,postbuf; string
; mov rax,1
; mov rdi,1
; syscall

; mov rdx,2; string lenght
; mov rsi,Newline; string
; mov rax,1
; mov rdi,1
; syscall

; mov rdx,2; string lenght
; mov rsi,Newline; string
; mov rax,1
; mov rdi,1
; syscall
    ; mov rax, 1          
    ; mov rdi, 1          
    ; mov rsi, postbuf 
    ; mov rdx, 50  
    ; syscall

lea rax,[postbuf]

pop rsi


xor r15,r15; When to write
xor r14,r14; POST lenght

cmp byte [rax],"0"
    je .del_cookies
xor rbx,rbx
mov bl,[rax]
sub bl,"0"

cmp bl, 9
ja .P_end


imul rbx,8
mov rcx,[POST_pointers + rbx]
lea r14,[POST_lenghts + rbx]
test rcx,rcx; RCX -> pointer to the value to WRITE TO
jz .endR
.ReadPOST:
    mov bl,[rax]
    test bl,bl; when it detects 0 at the end of the string
    jz .exit

    cmp bl,"="
    jne .NoE; When value is being read
        mov r15,1; allows to write
        jmp .NextElement
    .NoE:
    cmp bl,"&"; Next POST reading
    jne .NoA
        xor r15,r15; disalows to write
        xor rdx,rdx
        mov dl,[rax+1]
        sub dl,"0"

        cmp dl, 9
        ja .P_end

        imul rdx,8
        mov rcx,[POST_pointers+rdx]
        test rcx,rcx; RCX -> pointer to the value to WRITE TO
        jz .endR; if useless POST detected, exits

            lea r14,[POST_lenghts + rdx]

            mov dl,[rax+1]; jeigu ne skaicius post tais iseina
            sub dl,"0"
            cmp dl,9
            ja .no_post
            
            jmp .NextElement

    .NoA:
    
    test r15,r15
    jz .NextElement
        mov byte [rcx],bl

        inc qword [r14]

        inc rcx
    .NextElement:
    
    inc rax
    jnz .ReadPOST
.exit:

xor rdx,rdx
mov dl,[val1]
test dl,dl
jz .No_New_Flag
    mov byte [CkFLAGS+13],dl
    sub rdx,"0"; better needs to be 
    inc rdx
    mov qword [IM],rdx; kad iskarto uzskaitytu
    print CkFLAGS,CkFLAGSL,[req + 16]
.No_New_Flag:

mov rcx,qword [POST_lenghts+8]; lenght of the user
test rcx,rcx
jz .RegInfo

lea rdx,[CkUserL + 13]; cookie contetn place
lea rsi,[LoginUser]; user chars
.Write2Cookies:
    mov bl,[rsi];Login chars
    mov byte [rdx],bl; writen to the cookies insides

    inc rsi
    inc rdx
    dec rcx
    jnz .Write2Cookies
mov byte [rdx],";"

mov rcx,[POST_lenghts+16]; lenght of the pass
test rcx,rcx
jz .no_post

lea rdx,[CkPassL + 13]; cookie content place
lea rsi,[LoginPass]; pass chars
.Write2Cookies2:
    mov bl,[rsi];Login chars
    mov byte [rdx],bl; writen to the cookies insides

    inc rsi
    inc rdx
    dec rcx
    jnz .Write2Cookies2
mov byte [rdx],";"

jmp .endR
.RegInfo:

mov rcx,qword [POST_lenghts+24]; lenght of the user
test rcx,rcx
jz .no_post

lea rdx,[CkUserL + 13]; cookie contetn place
lea rsi,[LoginUser]; user chars
.Write2CookiesA:
    mov bl,[rsi];Login chars
    mov byte [rdx],bl; writen to the cookies insides

    inc rsi
    inc rdx
    dec rcx
    jnz .Write2CookiesA
mov byte [rdx],";"

mov rcx,[POST_lenghts+32]; lenght of the pass
test rcx,rcx
jz .no_post

lea rdx,[CkPassL + 13]; cookie content place
lea rsi,[LoginPass]; pass chars
.Write2Cookies2A:
    mov bl,[rsi];Login chars
    mov byte [rdx],bl; writen to the cookies insides

    inc rsi
    inc rdx
    dec rcx
    jnz .Write2Cookies2A
mov byte [rdx],";"




jmp .endR
.del_cookies:
    print start,startl,[req + 16]
    print RemCookies,RemCookiesL,[req + 16]
    jmp .ContinueLogin
.endR:

