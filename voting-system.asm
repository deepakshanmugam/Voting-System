org 100h 
include "emu8086.inc"
define_pthis
define_print_num
define_print_num_uns
define_scan_num
define_clear_screen

.data
 array1 dw 101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130
 array2 dw 201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220
 array3 dw 301,302,303,304,305
 cnt1  db ?
 numr1 db ?
 cnt2  db ?
 numr2 db ?
 cnt3  db ?
 numr3 db ?
 tot db   ?
 lrgt  db ? 
 

.code

mov ax,@data
mov ds,ax
 
main:
 call clear_screen 
 call pthis     
 db "Finale Round",0
 printn ""
 printn ""         
 call pthis
 db 10,13,"  1.Spectator 2.OtherConstestant 3.Judges 4.Admin",0
 printn ""
 call scan_num
 mov al,cl
 cmp al,1
 je s1
 cmp al,2
 je s2
 cmp al,3
 je s3 
 cmp al,4
 je s4
 call pthis
 db 10,13,"Invalid choice",0 
 jmp main
 
s1:
 call clear_screen
 call pthis     
 db "Enter Your Login",0
 printn ""
 call scan_num
 mov al,cl
 mov cl,30
 lea si,array1

L1:
 cmp al,[si]
 je check1
 add si,2
 dec cl
 jnz L1
 call pthis
 db 10,13,"    invalid user",0 
 jmp main 
 
s2: 
 call clear_screen
 call pthis     
 db "Enter Your Login",0
 printn ""
 call scan_num
 mov al,cl
 mov cl,20
 lea si,array2

L2:
 cmp al,[si]
 je check2
 add si,2
 dec cl
 jnz L2
 call pthis
 db 10,13,"    invalid user",0 
 jmp main  
 

s3:              
 call clear_screen
 call pthis     
 db "Enter Your Login",0
 printn ""
 call scan_num
 cmp cl,0
 je exit
 mov al,cl
 mov cl,05
 lea si,array3

L3:
 cmp al,[si]
 je check3
 add si,2
 dec cl
 jnz L3
 call pthis
 db 10,13,"    invalid user",0 
 jmp main  
 
exit:
 call pthis
 db 10,13,"Invalid user",0
 jmp s3
 
check1:
 inc numr1                 
 call pthis
 db 10,13,"    valid user/Audience",0
 call clear_screen
 jmp vote1 
 
check2:
 inc numr2
  call pthis
 db 10,13,"    valid user/Contestant",0
  call clear_screen   
 jmp vote2
 
check3:
 inc numr3
  call pthis
 db 10,13,"    valid user/Judge",0
  call clear_screen        
 jmp vote3
 
vote1:
 mov [si],0 
 call pthis
 db 10,13,"        Vote For The Contestant",0
 printn    
 printn
 call pthis
 db 10,10,13,"     1.Con1  2.Con2  3.Con3 ",0
 printn      
 call scan_num
 cmp cl,1
 je c1 
 cmp cl,2
 je c2
 cmp cl,3
 je c3
 printn
 call pthis
 db 10,13,"  Invalid Option",0
 printn
 jmp vote1         
 
 
 
vote2:
 mov [si],0  
 call pthis
 db 10,13,"        Vote For The Contestant",0
 printn    
 printn
 call pthis
 db 10,10,13,"     1.Con1  2.Con2  3.Con3 ",0
 printn      
 call scan_num
 cmp cl,1
 je c1 
 cmp cl,2
 je c2
 cmp cl,3
 je c3
 printn
 call pthis
 db 10,13,"  Invalid Option",0
 printn
 jmp vote2     
 
 
vote3: 
 mov [si],0 
 call pthis
 db 10,13,"        Vote For The Contestant",0
 printn    
 printn
 call pthis
 db 10,10,13,"     1.Con1  2.Con2  3.Con3 ",0
 printn      
 call scan_num
 cmp cl,1
 je c1 
 cmp cl,2
 je c2
 cmp cl,3
 je c3
 printn
 call pthis
 db 10,13,"  Invalid Option",0
 printn
 jmp vote3
 
 
c1: 
 printn ""
 inc cnt1
 inc tot
 jmp main
 
 
c2:
 printn "" 
 inc cnt2
 inc tot
 jmp main
 
c3:
 printn ""
 inc cnt3
 inc tot
 jmp main

 
s4:
 call clear_screen
 call pthis     
 db "Enter Password",0
 printn ""
 call scan_num 
 mov al,cl
 cmp al,10
 jnz exitadmin
 printn ""

s6: 
 call clear_screen
 call pthis
 db 10,13,"1.Summary 2.Check_Proceed ",0
 printn ""
 call scan_num 
 cmp cl,1
 je s5
 cmp cl,2                                                     
 jmp find
 db 10,13,"Invalid choice",0
 jmp s4

exitadmin:
 printn ""
 call pthis     
 db "Enter Admin Login",0
 jmp main


s5:
 call clear_screen
 call pthis
 db 10,13,"    Summary",0
 printn ""
 call pthis
 db 10,10,13,"Individual votes",0
 printn "" 
 call pthis
 db 10,13,"con1",0 
 call pthis  
 db 10,13,"votes:",0 
 mov al,cnt1 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h

 call pthis
 db 10,13,"con2",0   
 call pthis  
 db 10,13,"votes:",0 
 mov al,cnt2 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h

 call pthis
 mov al,cnt3
 db 10,13,"con3",0 
 call pthis 
 db 10,13,"votes:",0 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h

 printn "" 
 call pthis
 db 10,13,"Audience",0  
 call pthis 
 db 10,13,"votes:",0 
 mov al,numr1 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h

 printn "" 
 call pthis
 db 10,13,"OtherContestants",0  
 call pthis 
 db 10,13,"votes:",0 
 mov al,numr2 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h

 printn "" 
 call pthis
 db 10,13,"Judges",0  
 call pthis 
 db 10,13,"votes:",0 
 mov al,numr3 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h 

 printn ""
 call pthis
 db "total votes received:",0
 mov al,tot 
 add al,48 
 mov dl,al 
 mov ah,02 
 int 21h


delay:
 mov cx,250
 f1:                                                      
  dec cx
  jnz f1
 jmp s6


find:
mov al,0
mov al,cnt2
cmp cnt1,al
jz reelection

mov al,0
mov al,cnt1
cmp al,cnt3
jz reelection

reelection:  
call pthis
db 10,13, "   Re-election",0
mov cnt1,0
mov cnt2,0
mov cnt2,0
mov numr1 ,0
mov numr2,0
mov numr3,0
mov tot,0
jmp main


result:
                                                            
 mov dx,0
 MOV AL,cnt1
 MOV LRGT,AL
 mov dl,cnt1
 CMP AL,cnt2
 JGE SKIP1
 MOV AL,cnt2
 MOV LRGT,AL
 mov dl,cnt2                                                       
 SKIP1:
 MOV AL,LRGT
 CMP AL,cnt3
 JGE SKIP2
 MOV AL,cnt3
 mov dl,cnt3
 skip2:
 hlt

res:
 cmp dl,cnt1
 jz cont1

 cmp dl,cnt2
 jz cont2

 cmp dl,cnt3
 jz cont3

 cont1:
  call clear_screen
  printn ""
  call pthis
  db 10,13,"      Election Winner :: Contestant 1",0 
  call pthis
  db 10,13,"votes:",0
  mov al,cnt1
  add al,48
  mov dl,al
  mov ah,02
  int 21h
  jmp delay

 cont2:     
  call clear_screen
  printn ""
  call pthis
  db 10,10,13,"    Election Winner :: Contestant 2",0
  call pthis
  db 10,13,"votes:",0
  mov al,cnt2
  add al,48
  mov dl,al
  mov ah,02
  int 21h
  jmp delay

 cont3:
  call clear_screen
  printn ""
  call pthis
  db "             Election Winner :: Contestant 3",0 
  call pthis
  db 10,13,"votes:",0
  mov al,cnt3
  add al,48
  mov dl,al
  mov ah,02
  int 21h
  jmp delay 