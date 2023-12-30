.model small
.stack 100h

.data
input1 db ?
input2 db ?
result db ?
operator db ?
output_msg db "Result: $"
menu_msg db "Enter operation (+, -, *, /): $"
input_prompt db "Enter operands (0-9): $"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display menu
    mov ah, 09h
    mov dx, offset menu_msg
    int 21h

    ; Read operator choice
    mov ah, 01h
    int 21h
    mov operator, al

    ; Display input prompt
    mov ah, 09h
    mov dx, offset input_prompt
    int 21h

    ; Read first operand
    mov ah, 01h
    int 21h
    sub al, '0' ; convert ASCII to numeric
    mov input1, al

    ; Read second operand
    mov ah, 01h
    int 21h
    sub al, '0' ; convert ASCII to numeric
    mov input2, al

    ; Perform calculation based on operator
    mov ah, 09h
    mov dx, offset output_msg
    int 21h

    mov al, input1

    cmp operator, '+' ; Addition
    je add_op
    cmp operator, '-' ; Subtraction
    je sub_op
    cmp operator, '*' ; Multiplication
    je mul_op
    cmp operator, '/' ; Division
    je div_op

    jmp exit

add_op:
    add al, input2
    jmp print_result

sub_op:
    sub al, input2
    jmp print_result

mul_op:
    mul input2
    jmp print_result

div_op:
    xor ah, ah
    mov bl, input2
    div bl
    jmp print_result

print_result:
    mov result, al
    add result, '0' ; Convert numeric to ASCII
    mov ah, 09h ; Display result
    mov dx, offset result
    int 21h
    jmp exit

exit:
    mov ah, 4Ch ; Terminate program
    int 21h

main endp
end main