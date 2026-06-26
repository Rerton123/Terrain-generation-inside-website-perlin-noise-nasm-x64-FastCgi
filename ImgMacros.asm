%macro LSB 0; Login screen background
    mov r15,LogMenuImg
    mov r14,ImgD1
    mov r12,PointConD
    mov rcx,10
    %%Load_s1:
        push r15; img name
        push r14; where to store
        push rcx; counter
        push r12; sizes


        mov rax,2
        mov rdi,r15; image name
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1; in case of error
        je .done

        mov r13,rax

        pop r12
        push r12

        mov rax,9
        xor rdi,rdi
        mov rsi,qword [r12]; amount of bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r13;file director
        xor r9,r9
        syscall

        cmp rax,-1; in case of error
        je .done
        
        
        
        pop r12
        pop rcx
        pop r14
        pop r15
        
        mov qword [r14],rax; stores result

        add r12,8
        add r15,10
        add r14,8

        dec rcx
        jnz %%Load_s1

    mov rbx,Tile_Pointers
    mov rax,Tile0
    mov rcx,10
    %%LoadTiles:
        push rax
        push rcx
        push rbx
        

        mov rdi,rax; bmp name pointer
        mov rax,2
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1
        je .done

        mov r11,rax; saves file director

        mov rax,9
        xor rdi,rdi
        mov rsi,630; bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r11; file director
        xor r9,r9
        syscall; returns rax as pointer to the memory
        
        cmp rax,-1
        je .done

        pop rbx
        mov qword [rbx],rax
        pop rcx
        pop rax

        add rbx,8; where to save data
        add rax,11; image names
        dec rcx
        jnz %%LoadTiles

    mov rbx,ND_layer_ponters
    mov rax,TileB0
    mov rcx,10
    %%LoadTilesB:
        push rax
        push rcx
        push rbx
        push r12

        mov rdi,rax; bmp name pointer
        mov rax,2
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1
        je .done

        mov r11,rax; saves file director

        mov rax,9
        xor rdi,rdi
        mov rsi,766; bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r11; file director
        xor r9,r9
        syscall; returns rax as pointer to the memory
        
        cmp rax,-1
        je .done

        pop r12
        pop rbx
        mov qword [rbx],rax
        pop rcx
        pop rax

        add r12,8
        add rbx,8; where to save data
        add rax,11; image names
        dec rcx
        jnz %%LoadTilesB

    mov rbx,ND_layer_ponters+80
    mov rax,TileB10
    mov rcx,1
    %%LoadTilesB2:
        push rax
        push rcx
        push rbx
        push r12

        mov rdi,rax; bmp name pointer
        mov rax,2
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1
        je .done

        mov r11,rax; saves file director

        mov rax,9
        xor rdi,rdi
        mov rsi,766; bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r11; file director
        xor r9,r9
        syscall; returns rax as pointer to the memory
        
        cmp rax,-1
        je .done

        pop r12
        pop rbx
        mov qword [rbx],rax
        pop rcx
        pop rax

        add r12,8
        add rbx,8; where to save data
        add rax,12; filenames
        dec rcx
        jnz %%LoadTilesB2

    mov rbx,SubTiles
    mov rax,SubTile0
    mov rcx,10
    %%LoadSubtile1:
        push rax
        push rcx
        push rbx
        push r12

        mov rdi,rax; bmp name pointer
        mov rax,2
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1
        je .done

        mov r11,rax; saves file director

        mov rax,9
        xor rdi,rdi
        mov rsi,630; bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r11; file director
        xor r9,r9
        syscall; returns rax as pointer to the memory
        
        cmp rax,-1
        je .done

        pop r12
        pop rbx
        mov qword [rbx],rax
        pop rcx
        pop rax

        add rbx,8; where to save data
        add rax,12; image names
        dec rcx
        jnz %%LoadSubtile1


    mov rbx,SubTiles
    add rbx,80
    mov rax,SubTile10
    mov rcx,10
    %%LoadSubtile2:
        push rax
        push rcx
        push rbx
        push r12

        mov rdi,rax; bmp name pointer
        mov rax,2
        mov rsi,2
        mov rdx,0
        syscall

        cmp rax,-1
        je .done

        mov r11,rax; saves file director

        mov rax,9
        xor rdi,rdi
        mov rsi,630; bytes to read
        mov rdx,1
        mov r10,1
        mov r8,r11; file director
        xor r9,r9
        syscall; returns rax as pointer to the memory
        
        cmp rax,-1
        je .done

        pop r12
        pop rbx
        mov qword [rbx],rax
        pop rcx
        pop rax

        add rbx,8; where to save data
        add rax,12; image names
        dec rcx
        jnz %%LoadSubtile2

    mov rax,2
    mov rdi,MainMenuImg9
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,1046666
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD11],rax

    mov rax,2
    mov rdi,DeckOpt1
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD12],rax

    mov rax,2
    mov rdi,DeckOpt2
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD13],rax

    mov rax,2
    mov rdi,DeckOpt3
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD14],rax

    mov rax,2
    mov rdi,DeckOpt4
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD15],rax

    mov rax,2
    mov rdi,DeckOpt5
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD16],rax

    mov rax,2
    mov rdi,DeckOpt6
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD17],rax

    mov rax,2
    mov rdi,SP_map
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,2186
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD18],rax

    mov rax,2
    mov rdi,ResetMap
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,630
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD19],rax

    mov rax,2
    mov rdi,BuildIco
    mov rsi,2
    mov rdx,0
    syscall
    cmp rax,-1
    je .done
    mov [fd],rax

    mov rax,9
    xor rdi,rdi
    mov rsi,622
    mov rdx,1
    mov r10,1
    mov r8,[fd]
    xor r9,r9
    syscall
    cmp rax,-1
    je .done
    mov [ImgD20],rax
%endmacro