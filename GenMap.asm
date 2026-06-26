%macro Write 2; string[pointer] and its lenght

mov rax,%1
mov rcx,%2
xor rbx,rbx
mov rdx,Gen_Asnwer
add rdx,rsi; rsi keeps the track of current item
%%WriteInto:
    mov bl,[rax]
    mov byte [rdx],bl

    inc rax
    inc rdx
    inc rsi
    dec rcx
    jnz %%WriteInto
%endmacro

%macro ChangeX 1
    mov rax,%1
    xor rdx,rdx
    mov rbx,10
    div rbx
    add dl,"0"
    mov byte [r15+2],dl
    xor rdx,rdx
    div rbx
    add dl,"0"
    mov byte [r15 + 1],dl
    xor rdx,rdx
    div rbx
    add dl,"0"
    mov byte [r15 + 0],dl
%endmacro

%macro ChangeY 1; ormal number input
    mov rax,%1

    xor rdx,rdx
    mov rbx,10
    div rbx
    add dl,"0"
    mov byte [r15+8],dl
    xor rdx,rdx
    div rbx
    add dl,"0"
    mov byte [r15 + 7],dl
    xor rdx,rdx
    div rbx
    add dl,"0"
    mov byte [r15 + 6],dl
%endmacro

%macro ChangeS 2; string number input
    mov byte [r15-5],%1
    mov byte [r15-4],%2
%endmacro

%macro Rand 1
    push rsi
    push rax
    push rbx
    push r11

    mov r11,[seed]
    imul r11,r11,6364117
    inc r11
    mov qword [seed],r11
    xor rdx,rdx
    mov rbx,%1
    mov rax,r11
    ; shr rax, 32
    div rbx; RDX -> output

    pop r11
    pop rbx
    pop rax
    pop rsi
%endmacro

%macro GenerateTerrain 0
    lea rsi,[Map+13]
    xor r12,r12
    xor r13,r13
    lea r8,[CkNDlayer+13]
    mov ch,25
    %%Column:
        mov cl,50
        xor r12,r12
        %%Row:
            push rcx
            push rsi

            mov r14,r12;cellx
            mov r15,r13;celly
            mov r9,r12;fx
            mov r10,r13;fy


            ;n = x*17 + y*57 + seed*131
            shr r14,4;cellx
            shr r15,4;celly


            and r9,15;fx
            and r10,15;fy
            
            ;n1
            mov rax, r14        ; cellx
            xor rax, r11        ; seed 
            imul rax, 374761393
            xor rax, r15        ; celly
            imul rax, 668265263
            xor rax, r11        
            
            mov rcx, rax
            shr rcx, 16
            xor rcx, rax
            shr rcx, 8
            xor rcx, rax
            and rcx, 7
            mov byte [nxx],cl

            ;n2
            mov rax,r14;cellx
            inc rax

            xor rax, r11        ; seed 
            imul rax, 374761393
            xor rax, r15        ; celly
            imul rax, 668265263
            xor rax, r11       

            mov rcx, rax
            shr rcx, 16
            xor rcx, rax
            shr rcx, 8
            xor rcx, rax
            and rcx, 7
            mov byte [nxx+1],cl


            ;n3
            mov rax, r14
            xor rax, r11
            imul rax, 374761393

            mov rbx, r15
            inc rbx

            xor rax, rbx
            imul rax, 668265263
            xor rax, r11

            mov rcx, rax
            shr rcx, 16
            xor rcx, rax
            shr rcx, 8
            xor rcx, rax
            and rcx, 7
            mov byte [nxx+2],cl


            ;n3
            mov rax, r14
            inc rax
            xor rax, r11
            imul rax, 374761393

            mov rbx, r15
            inc rbx

            xor rax, rbx
            imul rax, 668265263
            xor rax, r11

            mov rcx, rax
            shr rcx, 16
            xor rcx, rax
            shr rcx, 8
            xor rcx, rax
            and rcx, 7
            mov byte [nxx+3],cl


            movzx rax, byte [nxx]
            mov rbx, rax;
            shl rbx, 1
            movsx rdx, byte [gradients + rbx]     ; gx
            movsx rcx, byte [gradients + rbx + 1] ; gy
            mov rax, rdx
            imul rax, r9        ; gx * dx
            mov rbx, rcx
            imul rbx, r10        ; gy * dy
            add rax, rbx
            mov qword [dot],rax


            movzx rax, byte [nxx+1]
            mov rbx, rax
            shl rbx, 1

            movsx rdx, byte [gradients + rbx]     ; gx
            movsx rcx, byte [gradients + rbx + 1] ; gy

            mov rax, r9
            sub rax, 16
            imul rax, rdx

            mov rbx, r10
            imul rbx, rcx

            add rax, rbx
            mov qword [dot+8], rax


            movzx rax, byte [nxx+2]
            mov rbx, rax
            shl rbx, 1

            movsx rdx, byte [gradients + rbx]     ; gx
            movsx rcx, byte [gradients + rbx + 1] ; gy

            mov rax, r9
            
            imul rax, rdx

            mov rbx, r10
            sub rbx, 16
            imul rbx, rcx

            add rax, rbx
            mov qword [dot+16], rax


            movzx rax, byte [nxx+3]
            mov rbx, rax
            shl rbx, 1

            movsx rdx, byte [gradients + rbx]     ; gx
            movsx rcx, byte [gradients + rbx + 1] ; gy

            mov rax, r9
            sub rax, 16
            imul rax, rdx

            mov rbx, r10
            sub rbx, 16
            imul rbx, rcx

            add rax, rbx
            mov qword [dot+24], rax


            mov rax, [dot]      ; n00
            mov rbx, [dot+8]    ; n10

            sub rbx, rax        ; n10-n00
            imul rbx, r9        ; (n10-n00)*fx
            sar rbx, 4          ; divide by 16
            add rax, rbx        ; top row result

            mov [dot+32], rax

            mov rax, [dot+16]   ; n01
            mov rbx, [dot+24]   ; n11

            sub rbx, rax
            imul rbx, r9
            sar rbx, 4
            add rax, rbx

            mov [dot+40], rax


            mov rax, [dot+32]   ; top
            mov rbx, [dot+40]   ; bottom

            sub rbx, rax
            imul rbx, r10       ; * fy
            sar rbx, 4          ; /16
            add rax, rbx; noise value



            mov rbx,r13;y
            imul rbx,50;y*50
            add rbx,r12;y*50+x
            ; mov rbx,10
            imul rbx,buttonL; byte order
            add rbx,HeaderLenght;header
            add rbx,6; offset

            add rax,0


            pop rsi
            ; lea rsi,[Map + 13]

            cmp rax,0
            jg %%Not_Water

                ; push r11;WATER
                ; Rand 2
                ; pop r11
                
                mov dl,"0"
                mov byte [rsi+1],dl; save cookie
                mov byte [Gen_Asnwer+rbx],dl
                
                dec rbx
                mov byte [rsi],"0"
                mov byte [Gen_Asnwer+rbx],"0"   

                mov byte [r8],"0"
                mov byte [r8+1],"0"
                jmp %%DoneGen
            %%Not_Water:
            cmp rax,1
            jg %%Not_Sand



                mov dl,"2"
                mov byte [rsi+1],dl; save cookie
                mov byte [Gen_Asnwer+rbx],dl
                dec rbx

                mov byte [rsi],"0"; save to a cookie
                mov byte [Gen_Asnwer+rbx],"0"

                Rand 50
                cmp rdx,3
                jne %%NoShipwreck
                    mov byte [r8],"1"
                    mov byte [r8+1],"0"
                    jmp %%DoneGen
                %%NoShipwreck:
                    mov byte [r8],"0"
                    mov byte [r8+1],"0"
                jmp %%DoneGen

            %%Not_Sand:
            cmp rax,4
            ja %%NotPlains
                    mov dl,"4"
                    mov byte [rsi+1],dl; save cookie
                    mov byte [Gen_Asnwer+rbx],dl
                    dec rbx

                    mov byte [rsi],"0"; save to a cookie
                    mov byte [Gen_Asnwer+rbx],"0"

                    Rand 30
                    cmp rdx,19
                    jne %%NoStone
                        mov byte [r8],"0"
                        mov byte [r8+1],"3"
                        jmp %%DoneGen
                    %%NoStone:

                    Rand 35
                    cmp rdx,19
                    jne %%NoTree
                        mov byte [r8],"0"
                        mov byte [r8+1],"4"
                        jmp %%DoneGen
                    %%NoTree:

                    cmp rax,4
                    jne %%NoForest
                        Rand 3
                        cmp rdx,2
                        jne %%NoForest
                        mov byte [r8],"0"
                        mov byte [r8+1],"1"
                        jmp %%DoneGen
                    %%NoForest:
                        Rand 30
                        cmp rdx,29
                        jne %%NoTrash
                            mov rax,r8
                            and rax,2
                            shr rax,1
                            add al,"6"

                            mov byte [r8],"0"
                            mov byte [r8+1],al
                            jmp %%DoneGen
                        %%NoTrash:
                            mov byte [r8],"0"
                            mov byte [r8+1],"0"
                            jmp %%DoneGen
            %%NotPlains:
            cmp rax,6
            ja %%NotHigh

                    mov dl,"6"
                    mov byte [rsi+1],dl
                    mov byte [Gen_Asnwer+rbx],dl
                    dec rbx
                    mov byte [rsi],"0"; save to a cookie
                    mov byte [Gen_Asnwer+rbx],"0"
                    
                    Rand 40
                    cmp rdx,1
                    jne %%NoOre
                        mov rax,r8
                        and rax,2
                        shr rax,1
                        add al,"8"

                        mov byte [r8],"0"
                        mov byte [r8+1],al                        
                        jmp %%DoneGen
                    %%NoOre:
                    
                    cmp rax,6
                    je %%D2
                        Rand 3
                        cmp rdx,2
                        je %%NoForest

                        mov byte [r8],"0"
                        mov byte [r8+1],"1"
                        jmp %%DoneGen
                    %%D2:
                        ; Rand 10
                        ; cmp rdx,9
                        ; je %%NoForest

                        mov byte [r8],"0"
                        mov byte [r8+1],"2"
                        jmp %%DoneGen
            %%NotHigh:
                mov dl,"8"
                mov byte [rsi+1],dl
                mov byte [Gen_Asnwer+rbx],dl
                dec rbx
                mov byte [rsi],"0"; save to a cookie
                mov byte [Gen_Asnwer+rbx],"0"

                mov byte [r8],"0"
                mov byte [r8+1],"0"

            %%DoneGen:

            add r8,2

            add rsi,2
            pop rcx

            inc r12
            dec cl
            jnz %%Row
        
        inc r13
        dec ch
        jnz %%Column
    dec r8
    mov byte [r8],";"
%endmacro GenerateTerrain

%macro AllignEdges 0



lea r15,[Map+StartCk6L]
;ax ir bx bus tikrinimui
;ax > current tile
;bx > in check tile
mov r14,100;row lenght in bytes

mov r13,2500
add r13,r15
mov r12,Temp
mov r11,r15

mov ch,50
%%Column:
    mov cl,25
    %%Row:
        mov ax,[r15]        
        xor dl,dl

        mov rbx,r15
        dec rbx
        cmp rbx,0
        jl %%C1
            mov bx,[r15-2]
            cmp ax,bx
            jbe %%C1
                or dl,1
        %%C1:
        lea rbx,[r15-100]
        cmp rbx,r11
        jl %%C2
            mov bx,[r15-100]
            cmp ax,bx
            jbe %%C2
                or dl,2
        %%C2:
        mov rbx,r15
        add rbx,2
        cmp rbx,r13
        ja %%C3
            mov bx,[r15+2]
            cmp ax,bx
            jbe %%C3
                or dl,4
        %%C3:
        mov rbx,r15
        add rbx,r14
        cmp rbx,r13
        ja %%C4
            mov bx,[r15+r14]
            cmp ax,bx
            jbe %%C4
                or dl,8
        %%C4:

        test dl,dl
        jz %%NoSet
            add dl,"A"
            mov byte [r12],dl
            shr ax,8
            sub al,"1"
            shr al,1
            add al,"0"
            mov byte [r12+1],al
            jmp %%Done2
        %%NoSet:
            mov word [r12],ax
        %%Done2:
        add r12,2
        add r15,2
        dec cl
        jnz %%Row
    dec ch
    jnz %%Column

    mov r12,Temp
    lea r15,[Map+StartCk6L]
    mov rcx,1250
    %%FinishResults:
        mov ax,[r12]
        mov word [r15],ax

        add r12,2
        add r15,2
        dec rcx
        jnz %%FinishResults

    ; mov rax,1
    ; mov rdi,1
    ; mov rsi,Map
    ; mov rdx,MapL
    ; syscall
%endmacro
cmp byte [ChangeButton],0
je .NoButtonCliked
    cmp byte [BuildCk],0
    je .NoButtonCliked
        cmp byte [BuildCk+1],"1"
        jne .NoButtonCliked
            mov rbx, [ChangeButton]
            movzx rax,bl; xooo
            sub al,"0"
            imul rax,10
            shr rbx,8
            movzx rcx,bl; oxoo
            sub cl,"0"
            add al,cl

            
            shr rbx,8
            movzx rcx,bl; ooxo
            sub cl,"0"
            imul rcx,10
            shr rbx,8
            add rcx,rbx; ooox
            sub rcx,"0"
            imul rcx,50
            add rax,rcx

            imul rax,2
            
            mov dl,[BuildCk+2]
            mov bl,[BuildCk+3]
            mov byte [SavedMap + rax],dl
            inc rax
            mov byte [SavedMap + rax],bl

            print StartCk6,StartCk6L,[req + 16]
            print SavedMap,2500,[req + 16]
            print EndCk6,EndCk6L,[req + 16]

            mov rdx,5 
            mov rsi,ChangeButton
            mov rax,1
            mov rdi,1
            syscall
    ; mov rdx,6;lenght
    ; lea rsi,[val1+1];string
    ; mov rax,1
    ; mov rdi,1
    ; syscall
.NoButtonCliked:


cmp byte [BuildP],0; BuildMenu, the bar which shows what to build
je .NoBuild
    cmp byte [BuildP],"b";IF POST FIRST LETTER = 'b'
    jne .NoToggle

        mov al,[BuildP+1]
        mov byte [CkInteraction+13],"b"
        mov byte [CkInteraction+14],al
        mov byte [CkInteraction+15],"0"
        mov byte [CkInteraction+16],"0"

        sub al,"0"
        mov byte [TempVal],al
        test al,al
        jz .Set
            mov byte [BuildB1+45],"0"
            print CkInteraction,CkInteractionL,[req + 16]
            jmp .BuildTheMenu
        .Set:
            mov byte [BuildB1+45],"1"
            print CkInteraction,CkInteractionL,[req + 16]
            jmp .NoBuildCookie

    .NoToggle: ; DEFINING OF WHICH BLOCK TO BUILD
        mov al,[BuildP]
        mov bl,[BuildP+1]
        mov byte [CkInteraction+15],al
        mov byte [CkInteraction+16],bl
        print CkInteraction,CkInteractionL,[req + 16]
    .BuildTheMenu:
    
    ; jmp .NoBuildCookie
.NoBuild:

cmp byte [BuildCk],0; Build menu idle, no post
je .NoBuildCookie

    cmp byte [BuildCk+1],"0"
    je .Reverse
        mov byte [BuildB1+45],"0"
        jmp .NoBuildCookie
    .Reverse:    
        mov byte [BuildB1+45],"1"
.NoBuildCookie:



cmp byte [val2],0
jne .Gen

cmp byte [SavedMap],0
jne .Load
    .Gen:
    lea r15,[button + 10]
    xor rsi,rsi

    mov rbx, qword [timespec]
    inc rbx
    mov r11,rbx
    mov qword [timespec],rbx

    push rsi
    GenerateTerrain

    
    mov byte [rsi],";"

    AllignEdges

    print Map,MapL,[req + 16]
    print CkNDlayer,CkNDlayerL,[req + 16]
    print Newline,2,[req + 16]
    print Newline,2,[req + 16]
    pop rsi
    ; print Gen_Asnwer,rsi,[req + 16]
    print ReturnB1,ReturnB1L,[req + 16]
    print ResetB1,ResetB1L,[req + 16]
    print BuildB1,BuildB1L,[req + 16]
    jmp .DoneGeneration
.Load:
print Newline,4,[req + 16]
xor rsi,rsi

lea r15,[button + 10]

print ReturnB1,ReturnB1L,[req + 16]
print ResetB1,ResetB1L,[req + 16]
print BuildB1,BuildB1L,[req + 16]
.DoneGeneration:

print Style,StyleL,[req +16]

mov al,[TempVal]
cmp al,2
je .NoTemp
    test al,al
    jz .NotOpenB
        print BuildMenu,BuildMenuL,[req + 16]
        jmp .NotOpenB
.NoTemp:
cmp byte [BuildCk+1],"1"
jne .NotOpenB
    print BuildMenu,BuildMenuL,[req + 16]
.NotOpenB:


print UnShort,UnShortL,[req + 16]
; print PO,POL,[req + 16]
; print PC,PCL,[req + 16]
jmp .NoLog
