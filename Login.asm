%macro hash 2
    mov rax,5321
    mov rsi,%1
    mov rcx,[%2]
    xor rbx,rbx
    %%Combine:
        mov bl,[rsi]

        mov rdx,rax
        shl rax,5
        add rax,rdx
        add rax,rbx
        
        inc rsi
        dec rcx 
        jnz %%Combine
    xor rdx,rdx
    mov rbx,100000
    div rbx

    mov [HashN],rdx
    lea rsi,[CkToken+4]
    add rsi,17
    mov rax,rdx
    mov rbx,10
    mov ecx,5
    mov r9,0
    %%HashStr:
        xor rdx,rdx
        div rbx

        add dl,"0"
        mov [rsi],dl
        dec rsi
        inc r9
        dec ecx
        jnz %%HashStr
%endmacro

%macro Hash2ByteIndex 0
    mov rax,[HashN]
    mov rbx,100
    mul rbx

    ;mov rax, 1858900
    push rax
    mov rbx,10
    lea rdi,[debugA + 15]
    mov rcx,16
    %%debug:
        xor rdx,rdx
        div rbx
        add dl,"0"
        mov byte [rdi],dl

        dec rdi
        dec rcx
        jnz %%debug
    pop rax
%endmacro

%macro Str2NumA 2
mov rax,%1; string
mov rcx,%2; string lenght
xor rdx,rdx
xor rbx,rbx
%%Convert:
    mov bl,[rax]
    test bl,bl
    jz %%done
    sub bl,"0"
    imul rdx,rdx,10
    add rdx,rbx
    inc rax
    dec rcx
    jnz %%Convert
%%done:
;RDX -> output
%endmacro

%macro HashLogin 0
    Hash2ByteIndex; rax = Byte index
    
    mov rbx,[data]
    add rbx,rax
    push rbx
    %%Search:
        movzx ax, byte [rbx]
        bt ax,0; 0 - nera paskyros; 1 - yra paskyra
        jc %%IsAcc
            mov byte [TestM],5; Username or password wrong
            jmp %%over
        %%IsAcc:
            inc rbx; nuo [1 byte skaito
            lea rdi, [LoginUser]
            mov rcx,16
            %%CompareUser:
                mov al,[rdi]
                cmp al,byte [rbx]
                jne %%NoMatchU
                    inc rbx
                    inc rdi
                    dec rcx
                    jnz %%CompareUser

            lea rdi,[LoginPass]
            mov rcx,16
            %%ComparePass:; palygina sekancius 16 bytes
                mov al,[rdi]
                cmp al,byte [rbx]
                jne %%NoMatchP
                    inc rbx
                    inc rdi
                    dec rcx
                    jnz %%ComparePass
            mov byte [TestM],1

            print CkUserL,CkUserLL,[req + 16]
            print CkPassL,CkPassLL,[req + 16]
            print CkToken,CkTokenL,[req + 16]
            mov r15,2

            jmp %%over
            %%NoMatchU:
                mov byte [TestM],3; Username or password wrong
                jmp %%continue
            %%NoMatchP:
                mov byte [TestM],3; Username or password wrong
                jmp %%over
            %%continue:
    pop rbx
    add rbx,100
    push rbx
    jmp %%Search
    %%over:
%endmacro

%macro HashRegister 0
Hash2ByteIndex; output rax = Byte index

mov rbx,[data]
add rbx,rax
push rbx

%%Search:
    movzx dx, byte [rbx]; yraso [0] byte
    bt dx,0; 0 - nera paskyros; 1 - yra paskyra
    jc %%IsAcc; jeigu nera paskyros, registrouja

        mov byte [rbx],1; pirmas byte -> 1
        inc rbx; rbx -> byte[1]
        lea rdx,[RegUser]; RegUser pointer
        mov rcx,16
        %%RegisterUser:; yraso Register Username y data,16 byte
            mov al,[rdx]

            mov byte [rbx],al

            inc rdx
            inc rbx
            dec rcx
            jnz %%RegisterUser
        %%DoneRegUser:

        lea rdx,[RegPass]; RegUser pointer
        mov rcx,16
        %%RegisterPass:; yraso Register Username y data,16 byte
            mov al,[rdx]

            mov byte [rbx],al

            inc rdx
            inc rbx
            dec rcx
            jnz %%RegisterPass
        %%DoneRegPass:
        mov byte [TestM],2; REGISTERED
            print CkToken,CkTokenL,[req + 16]
            print CkUserL,CkUserLL,[req + 16]
            print CkPassL,CkPassLL,[req + 16]
            mov r15,2
        jmp %%over
    %%IsAcc:
        inc rbx
        mov rcx,16
        lea rdi, [RegUser]
        %%CompareUser:   
            mov al, [rdi]
            cmp al, byte [rbx]
            jne %%NotEqual

                inc rdi
                inc rbx

                dec rcx
                jnz %%CompareUser
            
            mov byte [TestM],4; USERNAME TAKEN
            jmp %%over
        %%NotEqual:
            ;print Debug2,Debug2L,[req + 16]

    pop rbx
    add rbx,100
    push rbx
    jmp %%Search
%%over:
%endmacro


mov rdi, content_len; Receaves POST
mov rsi, [req + 32]
call FCGX_GetParam
test rax, rax;Jeigu post nera, iseina
jz .no_post; if no POST it just skips this part

    %include "LoginPostGet.asm" 
    cmp r15,15
    je %%no_token

    cmp qword [ArgL],0
    je .no_post
    ; mov rax,1
    ; mov rdi,1
    ; mov rsi,LoginUser
    ; mov rdx,[ArgL]
    ; syscall
    mov bl,0
    cmp byte [LoginUser],bl
    je %%RegHash
        mov rax,1
        mov rdi,1
        mov rsi,LoginUser
        mov rdx,[ArgL]

        hash LoginUser,ArgL
        HashLogin
        jmp %%no_token
    %%RegHash:
    cmp byte [RegUser],bl
    je %%NoUser
        hash RegUser,ArgL
        HashRegister
        jmp %%no_token
    %%NoUser:
.no_post:

xor r15,r15; ar yra TOken ar ne
mov rdi, cookieParm; isgauna POST, parametras = ka toky
mov rsi, [req + 32]
call FCGX_GetParam
test rax,rax; rax = pointer y 
jz %%no_token;Jeigu yra token, jy loadina

    xor r10,r10
    xor rcx,rcx
    xor rbx,rbx
    mov rsi,Token
    xor r9,r9
    mov r11,LoginUser
    mov r12,LoginPass
    ; xor r13,r13; Username ilgis
    cmp byte [rax],"T"; Jeigu Token cookie eina
    jne %%c2C
        mov r15,1
        mov byte [WasToken],1
        mov r10,1
        jmp %%GetToken
    %%c2C:
    cmp byte [rax],"L"; Jeigu Login cookie, jy getina
    jne %%GetToken
        cmp byte [rax+1],"p"
        je %%PassC
            mov r10,2
            jmp %%GetToken
        %%PassC:
            mov r10,3
    jmp %%GetToken


    %%GetToken:
        mov bl,[rax]
        test bl,bl
        jz %%Turned; 0 = galas string
            cmp bl, ";"; patikrina ar sekantis cookie
            jne %%nnc
                xor r9,r9
                cmp byte [rax+1]," "
                jne %%Nspace
                    cmp byte [rax+2],"T"; Jeigu Token cookie eina
                    jne %%c2
                        mov r15,1
                        mov byte [WasToken],1
                        mov r10,1
                        jmp %%nnc
                    %%c2:
                    cmp byte [rax+2],"L"; Jeigu Login cookie, jy getina
                    jne %%nnc
                        cmp byte [rax+3],"p"
                        je %%Pass
                            mov r10,2
                            jmp %%nnc
                        %%Pass:
                            mov r10,3
                    jmp %%nnc
                %%Nspace:
                    cmp byte [rax+1],"T"; Jeigu Token cookie eina
                    jne %%c2b
                        mov r15,1
                        mov byte [WasToken],1
                        mov r10,1
                        jmp %%nnc
                    %%c2b:
                    cmp byte [rax+1],"L"; Jeigu Login cookie, jy getina
                    jne %%nnc
                        cmp byte [rax+2],"p";Ar password ar user pirma
                        je %%PassB
                            mov r10,2
                            jmp %%nnc
                        %%PassB:
                            mov r10,3
                    jmp %%nnc
            %%nnc:
            cmp bl,"="; skaito skaicius tik po '='
            jne %%NoEq
                mov r9,1
                jmp %%NotYet
            %%NoEq:
            test r9,r9
            jz %%NotYet
                cmp r10,1
                jne %%NotToken
                    mov [rsi],bl
                    inc rsi
                    sub bl,"0"
                    imul rcx,rcx,10
                    add rcx,rbx
                    jmp %%Cheked
                %%NotToken:
                cmp r10,2
                jne %%NotUser
                    mov [r11],bl
                    inc r11
                    ; inc r13
                    jmp %%Cheked
                %%NotUser:
                    mov [r12],bl
                    inc r12
                %%Cheked:
        %%NotYet:
        inc rax
        jmp %%GetToken
    %%Turned:
    cmp byte [WasToken],0
    je %%no_token

    mov qword [HashN],rcx
    HashLogin
%%no_token:; jeigu nera token patikrina ar yra duomenys yvesti



