%macro print 3
    lea rdi, [%1]; array string pointer
    mov rsi, %2; array lenght
    mov rdx, %3; [req + 16]
    call FCGX_PutStr
%endmacro

%macro printA 3
    mov rdi, %1; array string pointer
    mov rsi, %2; array lenght
    mov rdx, %3; [req + 16]
    call FCGX_PutStr
%endmacro

%macro hash 2
    mov rax,5321
    mov rsi,%1
    mov rcx,%2
    xor rbx,rbx
    %%Combine:
        mov bl,[rsi]

        ; push rsi
        ; push rcx
        ; push rax
        ; push rbx

        ; mov byte [thing],bl
        ; mov rax,1
        ; mov rdi,1
        ; mov rsi,thing
        ; mov rdx,1
        ; syscall

        ; pop rbx
        ; pop rax
        ; pop rcx
        ; pop rsi


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
    lea rsi,[CkToken+17]

    mov rax,rdx
    mov rbx,10
    mov ecx,5
    mov r9,0; xor r9,r9
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

%macro Log 0

    mov rdi, content_len; Receaves POST lenght
    mov rsi, [req + 32]
    call FCGX_GetParam
    test rax, rax;Jeigu post nera, iseina
    jz .no_post; if no POST it just skips this part

        %include "LoginPostGet.asm" 
        cmp r15,15
        je %%no_token

        mov bl,0
        cmp byte [POST_lenghts+8],bl
        je %%RegHash

            mov rdx, [POST_lenghts+8]
            cmp rdx,16
            ja .done
            hash LoginUser,rdx
            
            ; mov rax,1
            ; mov rdi,1
            ; mov rsi,CkToken
            ; mov rdx,CkTokenL
            ; syscall

            HashLogin
            jmp %%no_token
        %%RegHash:
        cmp byte [POST_lenghts+24],bl
        je %%NoUser

            ; mov rax,1
            ; mov rdi,1
            ; mov rsi,CkToken
            ; mov rdx,CkTokenL
            ; syscall

            mov rdx, [POST_lenghts+24]
            cmp rdx,16
            ja .done
            hash LoginUser,rdx

            HashRegister
            jmp %%no_token
        %%NoUser:
    .no_post:

    ; mov rax,1
    ; mov rdi,1
    ; mov rsi,True
    ; mov rdx,TrueL
    ; syscall

    xor r15,r15; ar yra TOken ar ne
    mov rdi, cookieParm; isgauna cookies
    mov rsi, [req + 32]
    call FCGX_GetParam;example: 1=bb; 2=bb; 5=97901
    test rax,rax; rax = pointer y cookie
    
    ; push rax
    ; mov rsi,rax
    ; mov rax,1
    ; mov rdi,1
    ; mov rdx,10
    ; syscall
    ; pop rax


    jz %%no_token;Jeigu yra cookies, juos perskaito

        xor r14,r14; kada skaityti

        xor rbx, rbx
        mov bl,[rax]
        sub rbx,"0"        
        cmp rbx,9
        ja %%no_token
        imul rbx,rbx,8
        mov rsi,[COOKIE_pointers + rbx]
        lea rdx,[COOKIE_lenghts + rbx]
        mov qword [rdx],0; cleans value 

        test rsi,rsi; Protection incase wrong cookie passed
        jz %%no_token


        %%Get:
            mov bl,[rax]
            test bl,bl
            jz %%C_done

            cmp bl,"="
            jne .NE
                mov r14,1
                jmp .SkipByte
            .NE:
            cmp bl,";"
            jne .NC
                cmp byte [rax+1],32; neigu neaptinka space po ";" tada klaida
                jne %%no_token

                xor r13,r13
                mov r13b,[rax+2]
                sub r13,"0"
                imul r13,r13,8
                mov rsi,[COOKIE_pointers + r13]; naujas cookie
                lea rdx,[COOKIE_lenghts + r13]
                mov qword [rdx],0

                test rsi,rsi; Protection incase wrong cookie passed
                jz %%no_token
                cmp r13,72
                ja %%no_token

                xor r14,r14; neleidiza rasyti
                jmp .SkipByte
            .NC:

            test r14,r14
            jz .SkipByte
                mov [rsi],bl
                inc rsi
                inc qword [rdx]; tracks lenght
                ; push rax; basic debug
                ; push rsi
                ; mov rsi,rax
                ; mov rax,1
                ; mov rdi,1
                ; mov rdx,1
                ; syscall
                ; pop rsi
                ; pop rax
            .SkipByte:
            
            inc rax
            jmp %%Get
        %%C_done:

        mov rax,1
        mov rdi,1
        mov rsi,True
        mov rdx,TrueL
        syscall

        ;debug
        ; mov rax,1
        ; mov rdi,1
        ; mov rsi,LoginUser
        ; mov rdx,[COOKIE_lenghts + 8]
        ; syscall

        ; mov rax,1
        ; mov rdi,1
        ; mov rsi,LoginPass
        ; mov rdx,[COOKIE_lenghts + 16]
        ; syscall

        ; mov rax,1
        ; mov rdi,1
        ; mov rsi,Token
        ; mov rdx,5
        ; syscall

            ; mov rdx,TureL; string lenght
            ; mov rsi,True; string
            ; mov rax,1
            ; mov rdi,1
            ; syscall


    mov rsi,[COOKIE_lenghts + 40]
    Str2NumA Token,rsi
    mov qword [HashN],rdx
    mov r15,3
    HashLogin
    %%no_token:; jeigu nera token patikrina ar yra duomenys yvesti

%endmacro

%macro Hash2ByteIndex 0
    mov rax,[HashN]
    mov rbx,100
    mul rbx

    ;mov rax, 1858900
    ; push rax; debug
    ; mov rbx,10
    ; lea rdi,[debugA + 15]
    ; mov rcx,16
    ; %%debug:
    ;     xor rdx,rdx
    ;     div rbx
    ;     add dl,"0"
    ;     mov byte [rdi],dl

    ;     dec rdi
    ;     dec rcx
    ;     jnz %%debug
    ; pop rax
%endmacro

%macro Str2NumWithTerm 0
    xor rsi,rsi
    xor rbx,rbx
    %%String2N:; Gauta string ilgi string convertuoja y naudojama numery
        mov bl,byte [rax]
        cmp bl,0
        je %%DoneS2N
            sub bl,"0"
            imul rsi,rsi,10
            add rsi,rbx
            inc rax
            jmp %%String2N
    %%DoneS2N:
%endmacro Str2NumWithTerm

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

            cmp r15,3
            je %%SkipSaveCk
            print CkUserL,CkUserLL,[req + 16]
            print CkPassL,CkPassLL,[req + 16]
            print CkToken,CkTokenL,[req + 16]
            print CkFLAGS,CkFLAGSL,[req + 16]
            %%SkipSaveCk:
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
        lea rdx,[LoginUser]; RegUser pointer
        mov rcx,16
        %%RegisterUser:; yraso Register Username y data,16 byte
            mov al,[rdx]

            mov byte [rbx],al

            inc rdx
            inc rbx
            dec rcx
            jnz %%RegisterUser
        %%DoneRegUser:

        lea rdx,[LoginPass]; RegUser pointer
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
            print CkFLAGS,CkFLAGSL,[req + 16]
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


%macro Str2NumA 2
mov rax,%1; string
mov rcx,%2; string lenght
xor rdx,rdx
xor rbx,rbx
%%Convert:
    mov bl,[rax]
    test bl,bl
    jz %%done
        cmp bl,32
        je %%done
            sub bl,"0"
            imul rdx,rdx,10
            add rdx,rbx
            inc rax
            dec rcx
            jnz %%Convert
%%done:
;RDX -> output
%endmacro