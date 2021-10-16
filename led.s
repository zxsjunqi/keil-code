RCC_APB2ENR EQU 0x40021018;配置RCC寄存器,时钟,0x40021018为时钟地址
GPIOC_CRH EQU 0x40011004;配置GPIOC_CRH寄存器，是端口配置高寄存器，高位的偏移地址为0x04 
GPIOC_ORD EQU 0x4001100c;配置GPIOC_ORD寄存器，是端口输出寄存器，输出由这里控制
GPIOA_CRL EQU 0x40010800;配置GPIOC_CRH寄存器，是端口配置高寄存器，高位的偏移地址为0x04 
GPIOA_ORD EQU 0x4001080C;配置GPIOC_ORD寄存器，是端口输出寄存器，输出由这里控制
GPIOB_CRH EQU 0x40010C04;配置GPIOC_CRH寄存器，是端口配置高寄存器，高位的偏移地址为0x04 
GPIOB_ORD EQU 0x40010C0C;配置GPIOC_ORD寄存器，是端口输出寄存器，输出由这里控制
Stack_Size EQU  0x00000400;栈的大小
;分配一个stack段，该段不初始化，可读写，按8字节对齐。分配一个大小为Stack_Size的存储空间，并使栈顶的地址为__initial_sp。
                AREA    STACK, NOINIT, READWRITE, ALIGN=3 ;NOINIT： = NO Init，不初始化。READWRITE : 可读，可写。ALIGN =3 : 2^3 对齐，即8字节对齐。
Stack_Mem       SPACE   Stack_Size
__initial_sp




                AREA    RESET, DATA, READONLY

__Vectors       DCD     __initial_sp               ; Top of Stack
                DCD     Reset_Handler              ; Reset Handler
                    
                    
                AREA    |.text|, CODE, READONLY
                    
                THUMB
                REQUIRE8
                PRESERVE8
                    
                ENTRY
Reset_Handler 
				bl LED_Init;bl：带链接的跳转指令。当使用该指令跳转时，当前地址(PC)会自动送入LR寄存器
MainLoop        BL LED_ON_C
                BL Delay
                BL LED_OFF_C
                BL Delay
				BL LED_ON_A
                BL Delay
                BL LED_OFF_A
                BL Delay
				BL LED_ON_B
                BL Delay
                BL LED_OFF_B
                BL Delay
                
                B MainLoop;B:无条件跳转。
LED_Init;LED初始化
                PUSH {R0,R1, LR};R0,R1,LR中的值放入堆栈
                
                LDR R0,=RCC_APB2ENR;LDR是把地址装载到寄存器中(比如R0)。
                ORR R0,R0,#0x1c;ORR 按位或操作,11100将R0的第二位置1，其他位不变
                LDR R1,=RCC_APB2ENR
                STR R0,[R1];STR是把值存储到寄存器所指的地址中，将r0里存储的值给rcc寄存器
				;上面一部分汇编代码是控制时钟的
				
				
                ;初始化GPIOA部分
                LDR R0,=GPIOA_CRL
                BIC R0,R0,#0x0fffffff;BIC 先把立即数取反，再按位与
                LDR R1,=GPIOA_CRL
                STR R0,[R1]
                ;上面的代码是初始化CPIOC_CRH
                LDR R0,=GPIOA_CRL
                ORR R0,#0x20000000;开启的是pc15，所以是2，为0100，是推挽输出模式，最大速度为2mhz
                LDR R1,=GPIOA_CRL
                STR R0,[R1]
				;GPIOC的端口配置高寄存器配置完毕，也就是CPIOA_CRH配置完成，端口的输出模式确定，不使用的都设为复位后的状态，为0100，所以上面处理输出为都是4
                ;将PC15置1
                MOV R0,#0x80; 二进制为0b1000 0000 ,第7位就是a7引脚的输出电压
                LDR R1,=GPIOA_ORD ;由r1控制ord寄存器
                STR R0,[R1] ;将ord寄存器的值变为r0的值
				
				 ;初始化GPIOB部分
                LDR R0,=GPIOB_CRH
                BIC R0,R0,#0xffffff0f;BIC 先把立即数取反，再按位与,用的是b9，所以把第二位置零
                LDR R1,=GPIOB_CRH
                STR R0,[R1]
                ;上面的代码是初始化CPIOC_CRH
                LDR R0,=GPIOB_CRH
                ORR R0,#0x00000020;开启的是pc15，所以是2，为0100，是推挽输出模式，最大速度为2mhz
                LDR R1,=GPIOB_CRH
                STR R0,[R1]
				;GPIOC的端口配置高寄存器配置完毕，也就是CPIOA_CRH配置完成，端口的输出模式确定，不使用的都设为复位后的状态，为0100，所以上面处理输出为都是4
                ;将PC15置1
                MOV R0,#0x200; 二进制为0b10 0000 0000,第16位就是b9引脚的输出电压
                LDR R1,=GPIOB_ORD ;由r1控制ord寄存器
                STR R0,[R1] ;将ord寄存器的值变为r0的值
				
				 ;初始化GPIOC部分
                LDR R0,=GPIOC_CRH
                BIC R0,R0,#0x0fffffff;BIC 先把立即数取反，再按位与，就是将三十二位全部置零
                LDR R1,=GPIOC_CRH
                STR R0,[R1]
                ;上面的代码是初始化CPIOC_CRH
                LDR R0,=GPIOC_CRH
                ORR R0,#0x20000000;开启的是pc15，所以是2，为0100，是推挽输出模式，最大速度为2mhz
                LDR R1,=GPIOC_CRH
                STR R0,[R1]
				;GPIOC的端口配置高寄存器配置完毕，也就是CPIOA_CRH配置完成，端口的输出模式确定，不使用的都设为复位后的状态，为0100，所以上面处理输出为都是4
                ;将PC15置1
                MOV R0,#0x8000; 二进制为0b1000 0000 0000 0000,第16位就是c15引脚的输出电压
                LDR R1,=GPIOC_ORD ;由r1控制ord寄存器
                STR R0,[R1] ;将ord寄存器的值变为r0的值
             
                POP {R0,R1,PC};将栈中之前存的R0，R1，LR的值返还给R0，R1，PC
LED_ON_A;亮灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x00 ;二进制为0b0000 0000 0000 0000，第16位为0，后面将作为pc15的输出电压
                LDR R1,=GPIOA_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1];将r0的值赋予在GPIOC_ORD中
             
                POP {R0,R1,PC}
             
LED_OFF_A;熄灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x80 ;二进制为0b 1000 0000 0000 0000，第16位为1，后面将作为pc15的输出电压
                LDR R1,=GPIOA_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1] ;[]是指对里面的地址操作，所以是将r0的值赋予GPIOC_ORD
             
                POP {R0,R1,PC}  
LED_ON_B;亮灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x000 ;二进制为0b0000 0000 0000 0000，第16位为0，后面将作为pc15的输出电压
                LDR R1,=GPIOB_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1];将r0的值赋予在GPIOC_ORD中
             
                POP {R0,R1,PC}
             
LED_OFF_B;熄灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x200 ;二进制为0b 1000 0000 0000 0000，第16位为1，后面将作为pc15的输出电压
                LDR R1,=GPIOB_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1] ;[]是指对里面的地址操作，所以是将r0的值赋予GPIOC_ORD
             
                POP {R0,R1,PC}  
LED_ON_C;亮灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x0000 ;二进制为0b0000 0000 0000 0000，第16位为0，后面将作为pc15的输出电压
                LDR R1,=GPIOC_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1];将r0的值赋予在GPIOC_ORD中
             
                POP {R0,R1,PC}
             
LED_OFF_C;熄灯
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x8000 ;二进制为0b 1000 0000 0000 0000，第16位为1，后面将作为pc15的输出电压
                LDR R1,=GPIOC_ORD ;将GPIOC的地址赋予r1
                STR R0,[R1] ;[]是指对里面的地址操作，所以是将r0的值赋予GPIOC_ORD
             
                POP {R0,R1,PC}             
             
Delay
                PUSH {R0,R1, LR}
                
                MOVS R0,#0
                MOVS R1,#0
                MOVS R2,#0
                
DelayLoop0        
                ADDS R0,R0,#1

                CMP R0,#330
                BCC DelayLoop0
                
                MOVS R0,#0
                ADDS R1,R1,#1
                CMP R1,#330
                BCC DelayLoop0 ;无进位

                MOVS R0,#0
                MOVS R1,#0
                ADDS R2,R2,#1
                CMP R2,#15
                BCC DelayLoop0
                
                
                POP {R0,R1,PC}    
                NOP
				END