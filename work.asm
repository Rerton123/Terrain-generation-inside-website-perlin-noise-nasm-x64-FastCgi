global main
extern FCGX_GetStr
extern FCGX_Init
extern FCGX_InitRequest
extern FCGX_Accept_r
extern FCGX_PutStr
extern FCGX_Finish_r
extern FCGX_GetParam


%include 'macros.asm'

section .data



start db "Content-Type: text/html",10,\
"Cache-Control: no-cache",10
startl  equ $ - start

POST_answer db "Status: 302 Found",13,10,\
"Location: /",13,10,13,10
POST_answerL equ $ - POST_answer

; WASM_answer db "Status: 200 OK",13,10,\
; "Content-Type: application/wasm",13,10,\
; "Content-Length: 43",13,10,13,10
; WASM_answerL equ $ - WASM_answer
; WasmCode:
; incbin "W.wasm"
; WasmCodeL equ $ - WasmCode

; CallWASM:
; db "<script>",13,10
; incbin "CallWASM.js"
; db "</script>",13,10
; CallWASML equ $ - CallWASM

LoginUser db 16 dup(0)
LoginPass db 16 dup(0)
RegUser db 16 dup(0)
RegPass db 16 dup(0)

Newline db 13,10,13,10

HashStr db 16 dup(0)
HashStrL dq 16

CkUserL db "Set-Cookie:1=                 Path=/; HttpOnly",10
CkUserLL equ $ - CkUserL
CkPassL db "Set-Cookie:2=                 Path=/; HttpOnly",10
CkPassLL equ $ - CkPassL
CkFLAGS db "Set-Cookie:3=    ; Path=/; HttpOnly",10
CkFLAGSL equ $ - CkFLAGS
CkPassR db "Set-Cookie:4=                ; Path=/; HttpOnly",10
CkPassRL equ $ - CkPassR
CkToken db "Set-Cookie:5=     ; Path=/; HttpOnly",10
CkTokenL equ $ - CkToken
CkNDlayer:
db "Set-Cookie:8="
times 2501 db 0
db " Path=/",13,10
CkNDlayerL equ $ - CkNDlayer
NDlayer db 2500 dup(0)


Wrong db "<h1>Wrong Password!</h1>",10
WrongL equ $ - Wrong
Map:
db "Set-Cookie:6="
times 2501 db 0
db "Path=/",13,10
MapL equ $ - Map
CkInteraction db "Set-Cookie:7=    ; Path=/; HttpOnly",10
CkInteractionL equ $ - CkInteraction

StartCk6 db "Set-Cookie:6="
StartCk6L equ $ - StartCk6
EndCk6 db "; Path=/",13,10
EndCk6L equ $ - EndCk6

RemCookies db "Set-Cookie: 1=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 2=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 3=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 7=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 5=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 6=; Path=/; Max-Age=0",13,10,\
"Set-Cookie: 4=; Path=/; Max-Age=0",13,10,13,10
RemCookiesL equ $ - RemCookies

code:
    incbin "test.js"
code_end:
code_len equ code_end - code

UnShort:
    db "<script>"
    incbin "UnShort.js"
    db "</script>"
UnShortL equ $ - UnShort



HashN dq 0
Token db 16 dup(0)
filename db "data",0
fd dq 0
data dq 0

Tile0 db "img/a0.bmp",0
Tile1 db "img/a1.bmp",0
Tile2 db "img/a2.bmp",0
Tile3 db "img/a3.bmp",0
Tile4 db "img/a4.bmp",0
Tile5 db "img/a5.bmp",0
Tile6 db "img/a6.bmp",0
Tile7 db "img/a7.bmp",0
Tile8 db "img/a8.bmp",0
Tile9 db "img/a9.bmp",0

TileB0 db "img/b0.ico",0
TileB1 db "img/b1.ico",0
TileB2 db "img/b2.ico",0
TileB3 db "img/b3.ico",0
TileB4 db "img/b4.ico",0
TileB5 db "img/b5.ico",0
TileB6 db "img/b6.ico",0
TileB7 db "img/b7.ico",0
TileB8 db "img/b8.ico",0
TileB9 db "img/b9.ico",0
TileB10 db "img/b10.ico",0

LogMenuImg db "img/0.bmp",0;10 bytes
MainMenuImg db "img/1.bmp",0
MainMenuImg1 db "img/2.bmp",0
MainMenuImg2 db "img/3.bmp",0
MainMenuImg3 db "img/4.bmp",0
MainMenuImg4 db "img/5.bmp",0
MainMenuImg5 db "img/6.bmp",0
MainMenuImg6 db "img/7.bmp",0
MainMenuImg7 db "img/8.bmp",0
MainMenuImg8 db "img/9.bmp",0

MainMenuImg9 db "img/10.bmp",0;11 bytes
DeckOpt1 db "img/11.bmp",0
DeckOpt2 db "img/12.bmp",0
DeckOpt3 db "img/13.bmp",0
DeckOpt4 db "img/14.bmp",0
DeckOpt5 db "img/15.bmp",0
DeckOpt6 db "img/16.bmp",0
SP_map db "img/17.bmp",0

ResetMap db "img/18.bmp",0
BuildIco db "img/19.bmp",0

%include "ImgRes.asm"
DebugX db 100 dup("X")


SubTile0 db "img/A00.bmp",0
SubTile1 db "img/A01.bmp",0
SubTile2 db "img/A02.bmp",0
SubTile3 db "img/A03.bmp",0
SubTile4 db "img/A04.bmp",0

SubTile5 db "img/A10.bmp",0
SubTile6 db "img/A11.bmp",0
SubTile7 db "img/A12.bmp",0
SubTile8 db "img/A13.bmp",0
SubTile9 db "img/A14.bmp",0

SubTile10 db "img/A20.bmp",0
SubTile11 db "img/A21.bmp",0
SubTile12 db "img/A22.bmp",0
SubTile13 db "img/A23.bmp",0
SubTile14 db "img/A24.bmp",0

SubTile15 db "img/A30.bmp",0
SubTile16 db "img/A31.bmp",0
SubTile17 db "img/A32.bmp",0
SubTile18 db "img/A33.bmp",0
SubTile19 db "img/A34.bmp",0

Tile_Pointers dq 30 dup(0)

ND_layer_ponters dq 30 dup(0)

SubTiles dq 32 dup(0)

ImgD1 dq 0
ImgD2 dq 0
ImgD3 dq 0
ImgD4 dq 0
ImgD5 dq 0
ImgD6 dq 0
ImgD7 dq 0
ImgD8 dq 0
ImgD9 dq 0
ImgD10 dq 0

ImgD11 dq 0
ImgD12 dq 0
ImgD13 dq 0
ImgD14 dq 0
ImgD15 dq 0
ImgD16 dq 0
ImgD17 dq 0
ImgD18 dq 0
ImgD19 dq 0
ImgD20 dq 0

PointConA: 
    dq Res1,Res2,Res3,Res3,Res3,Res4,Res3,Res3,Res3,Res5,Res6,Res7,Res7,Res7,Res7,Res7,Res7,Res7
    dq Res8,Res9

PointConB:
    dq Res1L,Res2L,Res3L,Res3L,Res3L,Res4L,Res3L,Res3L,Res3L,Res5L,Res6L,Res7L,Res7L,Res7L,Res7L,Res7L,Res7L,Res7L
    dq Res8L,Res9L

PointConC:
    dq ImgD1,ImgD2,ImgD3,ImgD4,ImgD5,ImgD6,ImgD7,ImgD8,ImgD9,ImgD10,ImgD11,ImgD12,ImgD13,ImgD14,ImgD15,ImgD16,ImgD17,ImgD18
    dq ImgD19,ImgD20

PointConD:
    dq 1692322,1694778,10138,10138,10138,9642,10138,10138,10138,1843338,1046666,2186,2186,2186,2186,2186,2186,2186
    dq 630,622

StructQue dq 512 dup(0)

seed dq 0

TestM db 0
Bite db 0
ArgL dq 0
ArgL2 dq 0
debugA db 16 dup(0)

%include "HtmlParts.asm"
PO db "<form method='POST' class='B'>"; post open
POL equ $ - PO

button db "<t i=00 x= 50 y= 50></t>",10
buttonL equ $ - button
HeaderLenght equ POL + StyleL
PC db "</form>"; post close
PCL equ $ - PC
SavedMap db 2501 dup(0); NOT CLEARED!

Gen_Asnwer db 40224 dup(0); 13
gradients:
    db  1, 0
    db -1, 0
    db  0, 1
    db  0,-1
    db  1, 1
    db -1, 1
    db  1,-1
    db -1,-1
nxx:
    db 0
    db 0
    db 0
    db 0
dot:
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
val1 db 16 dup(0);<<
val2 db 16 dup(0);<<needs name changes, as i am confusing these
val0 db 16 dup(0);<<
BuildP db 16 dup(0)
BuildCk dq 0
ChangeButton db 16 dup(0)
POST_pointers dq val0,LoginUser,LoginPass,LoginUser,LoginPass,val1,val2,BuildP,ChangeButton,ChangeButton,0,0,0,0,0,0
POST_lenghts dq 6 dup(0)
FLAGS dq 0
FLAGS_S dq 0

Temp dw 2500 dup(0)

ModifyedImg db 1024 dup(0)

COOKIE_pointers dq 0,LoginUser,LoginPass,FLAGS_S,0,Token,SavedMap,BuildCk,NDlayer
COOKIE_lenghts dq 0,0,0,0,0,0,0,0,0

TempVal db 2

IM dq 0
thing db 8 dup(0),13,10
Ani1:
    incbin "Ani1.js"
Ani1_end:
Ani1L equ Ani1_end - Ani1



req db 1024 dup(0); request struct
ReqParm db"REQUEST_METHOD",0
LinkParm db "REQUEST_URI",0
content_len db "CONTENT_LENGTH",0; parametro pasirinkimas
cookieParm db "HTTP_COOKIE",0
; MESSAGES for debugging


ImgName db 16 dup(0)

timespec dq 0     ; 16 bytes (SAFE)
True db "<h1>Logged in!</h1>",10
TrueL equ $ - True
False db "<h1>Incorrect password or username.</h1>"
FalseL equ $ - False
True2 db "<h1>Registered</h1>"
True2L equ $ - True2
False2 db "<h1>This username already exist</h1>"
False2L equ $ - False2
False3 db "<h1>This account doesn't exist</h1>"
False3L equ $ - False3
False4 db "|Username doesn't exist!|"
False4L equ $ - False4

WasToken db 0

; each side is own bit, so in total 16 combinations, for each is direction and tile variant
;ALIGN values (GenMap.asm)
;               a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p
CorrectSides db 0,5,0,1,4,4,0,4,2,3,1,1,2,5,0,0
CorrectParts db 1,0,0,1,0,2,1,4,0,1,2,4,1,4,4,3


section .bss

align 8
postbuf resb 1024
postlen resd 1        ; cmp byte [rax+1],0; DANGER zone

section .text


main:
    push rbp
    mov rbp, rsp
    push rbx
    sub rsp, 8


    %include "LoadMemoryData.asm"; loads "data" file memory
    %include "ImgMacros.asm"; loads image data
    LSB
    call FCGX_Init; prepares FCGX stuff, no inouts needed

    ; init request
    lea rdi, [req];location/pointer to FCGX_Request struct
    xor esi, esi; sock, 0 mostly
    xor edx, edx; flags, 0 mostly 
    call FCGX_InitRequest

    .loop:; NOTE all memory is for all users, so i reset at the end memory back
        lea rdi, [req]
        call FCGX_Accept_r;waits for next request
        cmp eax, 0
        jl .done
    
        mov rdi, LinkParm; 
        mov rsi, [req + 32]
        call FCGX_GetParam; request url
        test rax,rax
        jz .done

        cmp byte [rax+1],0
        jne .ImgRes
        
        
        
        Log; r15 = 2 tada prisijunge sekmingai
        push r15
        print start, startl, [req + 16]; Prints html start line
        pop r15
        cmp r15,2
        jne .ContinueLogin

            ; mov rdx,False4L; string lenght
            ; mov rsi,False4; string
            ; mov rax,1
            ; mov rdi,1
            ; syscall

            cmp qword [IM],0
            je .Already_Flag; Jeigu pries tai modifikuota
                mov rdx,[IM]
                dec rdx
                jmp .Out_Flag
            .Already_Flag:
                Str2NumA FLAGS_S,8
                mov qword [FLAGS],rdx
            .Out_Flag:

            test rdx,rdx;Menus from read cookies
            jnz .C1
                %include "Main_Menu.asm"
            .C1:
            cmp rdx,1
            jne .C2
                %include "MPmenu.asm"
            .C2:
            cmp rdx,3
            jne .C3
                %include "GenMap.asm"
            .C3:
                %include "SPmenu.asm"
        .ContinueLogin:
        print h1,h1l,[req + 16]

        ; print CallWASM,CallWASML,[req + 16]

        movzx ax,byte [TestM]; Login logs
        cmp ax,0
        je .c5
        cmp ax,1
        jne .c2
            print True,TrueL,[req + 16]
        .c2:
        cmp ax,2
        jne .c3
            print True2,True2L,[req + 16]
        jne .c3
        .c3:
        cmp ax,3
        jne .c4
            print False,FalseL,[req + 16]
        .c4:
        cmp ax,4
        jne .c5
            print False2,False2L,[req + 16]
        .c5:
        cmp ax,5
        jne .c6
            print False4,False4L,[req + 16]
        .c6:

        .NoLog:
        xor rbx,rbx
        mov ecx,2
        xor esi,esi
        .ClearPostL:; clears data to be used for next request
            mov qword [LoginUser+esi],0
            mov qword [LoginPass+esi],0
            mov qword [RegUser+esi],0
            mov qword [RegPass+esi],0
            mov qword [CkUserL+esi+13],0
            mov qword [CkPassL+esi+13],0
            ; mov qword [CkToken+esi+17],0
            mov qword [Token + esi],0
            mov qword [ImgName + esi],0 
            mov qword [postbuf + esi],0
            mov qword [POST_lenghts + esi],0
            mov qword [ChangeButton + esi],0
            add esi,8
            dec ecx
            jnz .ClearPostL
        mov qword [postbuf + esi],0
        mov qword [POST_lenghts + esi],0
        add esi,8
        mov qword [postbuf + esi],0
        mov qword [POST_lenghts + esi],0
        add esi,8
        mov qword [POST_lenghts + esi],0
        add esi,8
        mov qword [POST_lenghts + esi],0
        
        mov qword [FLAGS],32
        mov dword [CkToken+13],0
        mov byte [CkToken+17],0

        mov qword [CkFLAGS+13],0
        mov qword [ArgL],0
        mov qword [ArgL2],0
        mov byte [TestM],0
        mov byte [TestM],0
        mov qword [HashN],0
        mov byte [WasToken],0
        mov byte [val0],0
        mov qword [val1],0
        
        mov qword [IM],0



        mov qword [val2],0
        mov qword [BuildP],0
        mov byte [BuildB1+45],"1";resetina iskarto
        mov byte [TempVal],2

        mov rcx,625
        mov rax,SavedMap
        lea rbx,[Map+13]
        .ClearMap:
            mov dword [rax],0
            mov dword [rbx],0

            add rax,4
            add rbx,4
            
            dec rcx  
            jnz .ClearMap

        mov byte [rax],0
        mov byte [rbx],0
        jmp .P_end
        .ImgRes:
            ; jmp .done
            ; push rax
            ; mov rdx,10
            ; mov rsi,rax
            ; mov rax,1
            ; mov rdi,1
            ; syscall
            ; pop rax

            cmp byte [rax+1],"W"
            je .GiveWasm

            ; jmp .P_end
            add rax,5    

            cmp byte [rax],"b"
            je .Give2NDlayer
            cmp byte [rax],"a"
            je .GiveTile

            mov bl,[rax]


            cmp bl,"9"
            ja .P_end
            cmp bl,"0"
            jb .P_end

            xor rbx,rbx
            xor rsi,rsi
            .ImgReadN:
                mov bl,[rax]
                cmp bl,"."
                je .OuterLoop
                    sub bl,"0"
                    imul rsi,rsi,10
                    add rsi,rbx
                    inc rax
                    jmp .ImgReadN
            .OuterLoop:

            mov rbx,rsi
            imul rbx,rbx,8

            mov rax,[PointConA + rbx]
            mov rcx,[PointConB + rbx]
            print rax,rcx,[req + 16]
            
            mov r15,[PointConC + rbx]
            mov rdi, [r15]; array string pointer
            mov rsi, [PointConD + rbx]; array lenght
            mov rdx, [req + 16]; [req + 16]
            call FCGX_PutStr

            jmp .P_end

        .GiveWasm:
            print WASM_answer,WASM_answerL,[req + 16]


            print WasmCode,WasmCodeL, [req + 16]
            mov rdx,WASM_answerL; string lenght
            mov rsi,WASM_answer; string
            mov rax,1
            mov rdi,1
            syscall

            jmp .P_end
        .Give2NDlayer:
            inc rax

            xor rbx,rbx
            xor rsi,rsi
            .ImgReadN3:
                mov bl,[rax]
                test bl,bl
                jz .OuterLoop3
                cmp bl,"."
                je .OuterLoop3
                    sub bl,"0"
                    imul rsi,rsi,10
                    add rsi,rbx
                    inc rax
                    jmp .ImgReadN3
            .OuterLoop3:
            cmp rsi,10
            ja .P_end
            imul rsi,8


            push rsi
            mov rax,NDTileRes
            print rax,NDTileResL,[req + 16]
            pop rsi

            mov rdi, [ND_layer_ponters + rsi]; array string pointer
            mov rsi, 766; array lenght
            mov rdx, [req + 16]; [req + 16]
            call FCGX_PutStr
            jmp .P_end

        .GiveTile:;a0.bmp = tile, aa0 = subtile, 4 directions
            inc rax

            cmp byte [rax],"A"
            jae .GiveSubTile


            xor rbx,rbx
            xor rsi,rsi
            .ImgReadN2:
                mov bl,[rax]
                test bl,bl
                jz .OuterLoop2
                cmp bl,"."
                je .OuterLoop2
                    sub bl,"0"
                    imul rsi,rsi,10
                    add rsi,rbx
                    inc rax
                    jmp .ImgReadN2
            .OuterLoop2:
            cmp rsi,9
            ja .P_end
            imul rsi,8


            push rsi
            mov rax,TileRes
            print rax,TileResL,[req + 16]
            pop rsi

            mov rdi, [Tile_Pointers + rsi]; array string pointer
            mov rsi, 630; array lenght
            mov rdx, [req + 16]; [req + 16]
            call FCGX_PutStr
            jmp .P_end


            .GiveSubTile:
            ; push rax

            ; mov rsi,rax
            ; mov rax,1
            ; mov rdi,1
            ; mov rdx,3
            ; syscall

            ; mov rsi,Newline
            ; mov rax,1
            ; mov rdi,1
            ; mov rdx,2
            ; syscall

            ; pop rax



            push rax
            mov rax,TileRes
            print rax,TileResL,[req + 16]
            pop rax


            xor rbx,rbx
            ; ; imul rbx,8
            mov bl,[rax]
            sub bl,"A"
            ; cmp bl,15
            ; je .NoRor
                mov cl,[CorrectSides+rbx]
                test cl,cl
                jz .NoRor
                    ;cl > direction
                    ;r8b > part type
                    ;bl > biome
                    
                    
                    xor r8,r8
                    mov r8b,[CorrectParts+rbx]; part
                    mov bl,[rax+1]; biome
                    sub bl,"0"
                    imul rbx,40

                    cmp r8,4
                    ja .P_end

                    imul r8,8
                    add rbx,r8

                    ; jmp .RorSide
                    

                    cmp cl,1
                    je .RorX
                    cmp cl,2
                    je .RorY
                    cmp cl,3
                    je .RorXY
                    ; jmp .RorXY
                    cmp cl,5
                    je .RorSide2
                    jmp .RorSide
            .NoRor:
                movzx r8,byte [CorrectParts+rbx]
                
                movzx rcx,byte [rax+1]; [0;3] biome
                sub rcx,"0"
                imul rcx,40
                
                shl r8,3

                add rcx,r8
                


                ; mov rbx,14
                cmp rcx,160
                jb .good
                    mov rbx,0
                .good:

                mov rdi, [SubTiles+rcx]; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr
                jmp .P_end
            .RorX:
                mov r14,ModifyedImg
                mov r15,[SubTiles+rbx]; becomes pointer to the image
                mov rcx,118
                .ReadHeader:
                    mov al,[r15]
                    mov byte [r14],al

                    inc r14
                    inc r15
                    dec rcx
                    jnz .ReadHeader
                    
                add r15,15
                mov rcx,32
                .ReverseXColumn:
                    mov rdx,16
                    .ReverseXRow:
                        mov al,[r15];both 4,4bits
                        mov ah,al   
                        
                        shr ah,4;last 4 bits
                        
                        and al,0Fh;first 4 bits
                        shl al,4
                        or al,ah

                        mov byte [r14],al

                        dec r15
                        inc r14

                        dec rdx
                        jnz .ReverseXRow

                    add r15,32
                    dec rcx
                    jnz .ReverseXColumn

                mov rdi, ModifyedImg; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr
                
                jmp .P_end
            .RorY:
                mov r14,ModifyedImg
                mov r15,[SubTiles+rbx]; becomes pointer to the image
                mov rcx,118
                .ReadHeader2:
                    mov al,[r15]
                    mov byte [r14],al

                    inc r14
                    inc r15
                    dec rcx
                    jnz .ReadHeader2

                add r15,496;512-16
                mov rcx,32
                .ReverseYColumn:
                    mov rdx,16
                    .ReverseYRow:
                        mov al,[r15];both 4,4bits

                        mov byte [r14],al

                        inc r15
                        inc r14

                        dec rdx
                        jnz .ReverseYRow

                    sub r15,32
                    dec rcx
                    jnz .ReverseYColumn

                mov rdi, ModifyedImg; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr
                
                jmp .P_end
            .RorXY:
                mov r14,ModifyedImg
                mov r15,[SubTiles+rbx]; becomes pointer to the image
                mov rcx,118
                .ReadHeader3:
                    mov al,[r15]
                    mov byte [r14],al

                    inc r14
                    inc r15
                    dec rcx
                    jnz .ReadHeader3

                    add r15,511
                    mov rcx,512
                    .Reversed:
                        mov al,[r15];both 4,4bits
                        mov ah,al   
                        
                        shr ah,4;last 4 bits
                        
                        and al,0Fh;first 4 bits
                        shl al,4
                        or al,ah

                        mov byte [r14],al

                        inc r14
                        dec r15
                        dec rcx
                        jnz .Reversed

                mov rdi, ModifyedImg; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr
                
                jmp .P_end
            .RorSide:
                mov r15,ModifyedImg
                mov rcx,128
                .ClearTemp:
                    mov qword [r15],0
                    add r15,8
                    dec rcx
                    jnz .ClearTemp

                mov r14,ModifyedImg
                mov r15,[SubTiles+rbx]; becomes pointer to the image
                mov rcx,118
                .ReadHeader4:
                    mov al,[r15]
                    mov byte [r14],al

                    inc r14
                    inc r15
                    dec rcx
                    jnz .ReadHeader4

                

                ; add r14,511
                mov ch,16
                .FlipColumn:; r15 actual image r14 the new image
                    movzx rbx,cx
                    shr rbx,8; rbx = ch
                    dec rbx
                    xor rbx,1111b; oposite of ch counter
                    add rbx,r14
            
                    mov cl,16
                    .FlipRow:; Entire Modifyed image is zeroed before use
                        ; First 4 bits of pixels into first column
                        mov al,[r15];both 4,4bits
                        mov ah,al   ;last 4 bits
                        and al,11110000b; xxxx0000
                        and ah,1111b;other 4 bits
                        or byte [rbx],al;write first 4 bits
                        shr ax,4
                        or byte [rbx+16],al; xxxx0000

                        add rbx,32; kur yraso
                        add r15,1; is kur kopijuoja
                        dec cl
                        jnz .FlipRow

                    
                    movzx rbx,cx
                    shr rbx,8; rbx = ch => cl
                    dec rbx
                    xor rbx,1111b; oposite of ch counter
                    add rbx,r14

                    mov cl,16
                    .FlipRow2:; Entire Modifyed image is zeroed before use
                        ; Last 4 bits of pixels into first column
                        mov al,[r15];both 4,4bits
                        mov ah,al   ;first 4 bits
                        and al,11110000b; 0000xxxx
                        shr al,4
                        and ah,1111b;last 4 bits
                        or byte [rbx],al;write first 4 bits
                        shr ax,8

                        or byte [rbx+16],al; 0000xxxx

                        add rbx,32
                        add r15,1
                        dec cl
                        jnz .FlipRow2

                dec ch
                jnz .FlipColumn

                mov rdi, ModifyedImg; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr

                xor rbx,rbx
                jmp .P_end


            .RorSide2:
                mov r15,ModifyedImg
                mov rcx,128
                .ClearTemp2:
                    mov qword [r15],0
                    add r15,8
                    dec rcx
                    jnz .ClearTemp2

                mov r14,ModifyedImg
                mov r15,[SubTiles+rbx]; becomes pointer to the image
                mov rcx,118
                .ReadHeader5:
                    mov al,[r15]
                    mov byte [r14],al

                    inc r14
                    inc r15
                    dec rcx
                    jnz .ReadHeader5

                add r15,511
                mov ch,16
                .FlipColumn2:; r15 actual image r14 the new image
                    movzx rbx,cx
                    shr rbx,8; rbx = ch
                    dec rbx
                    xor rbx,1111b; oposite of ch counter

                    add rbx,r14
                    mov cl,16
                    .FlipRowA:; Entire Modifyed image is zeroed before use
                        ;First 4 bits of pixels into first column
                        mov al,[r15];both 4,4bits
                        mov ah,al   ;last 4 bits
                        and al,11110000b; xxxx0000
                        and ah,1111b;other 4 bits
                        or byte [rbx],al;write first 4 bits
                        shr ax,4
                        or byte [rbx+16],al; xxxx0000

                        ; ;Last 4 bits of pixels into first column
                        ; mov al,[rbx+1];both 4,4bits
                        ; mov ah,al   ;first 4 bits
                        ; and al,11110000b; 0000xxxx
                        ; shr al,4
                        ; and ah,1111b;last 4 bits
                        ; or byte [rbx],al;write first 4 bits
                        ; shr ax,8

                        ; or byte [rbx+16],al; 0000xxxx

                        add rbx,32; kur yraso
                        sub r15,1; is kur kopijuoja
                        dec cl
                        jnz .FlipRowA

                    
                    movzx rbx,cx
                    shr rbx,8; rbx = ch => cl
                    dec rbx
                    xor rbx,1111b; oposite of ch counter

                    ; sub r15,16; is kur skaitau

                    add rbx,r14
                    mov cl,16
                    .FlipRowB2:; Entire Modifyed image is zeroed before use
                        ;Last 4 bits of pixels into first column
                        mov al,[r15];both 4,4bits
                        mov ah,al   ;first 4 bits
                        and al,11110000b; 0000xxxx
                        shr al,4
                        and ah,1111b;last 4 bits
                        or byte [rbx],al;write first 4 bits
                        shr ax,8

                        or byte [rbx+16],al; 0000xxxx

                        add rbx,32
                        sub r15,1
                        dec cl
                        jnz .FlipRowB2

                dec ch
                jnz .FlipColumn2

                mov rdi, ModifyedImg; array string pointer
                mov rsi, 630; array lenght
                mov rdx, [req + 16]; [req + 16]
                call FCGX_PutStr

                xor rbx,rbx                
                jmp .P_end
        .P_end:
        ; xor rbx,rbx
        lea rdi, [req]; finish request
        call FCGX_Finish_r
        jmp .loop

.done:
    add rsp, 8
    pop rbx
    pop rbp
    xor eax, eax
    ret


