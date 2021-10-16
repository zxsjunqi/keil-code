RCC_APB2ENR EQU 0x40021018;����RCC�Ĵ���,ʱ��,0x40021018Ϊʱ�ӵ�ַ
GPIOC_CRH EQU 0x40011004;����GPIOC_CRH�Ĵ������Ƕ˿����ø߼Ĵ�������λ��ƫ�Ƶ�ַΪ0x04 
GPIOC_ORD EQU 0x4001100c;����GPIOC_ORD�Ĵ������Ƕ˿�����Ĵ�����������������
GPIOA_CRL EQU 0x40010800;����GPIOC_CRH�Ĵ������Ƕ˿����ø߼Ĵ�������λ��ƫ�Ƶ�ַΪ0x04 
GPIOA_ORD EQU 0x4001080C;����GPIOC_ORD�Ĵ������Ƕ˿�����Ĵ�����������������
GPIOB_CRH EQU 0x40010C04;����GPIOC_CRH�Ĵ������Ƕ˿����ø߼Ĵ�������λ��ƫ�Ƶ�ַΪ0x04 
GPIOB_ORD EQU 0x40010C0C;����GPIOC_ORD�Ĵ������Ƕ˿�����Ĵ�����������������
Stack_Size EQU  0x00000400;ջ�Ĵ�С
;����һ��stack�Σ��öβ���ʼ�����ɶ�д����8�ֽڶ��롣����һ����СΪStack_Size�Ĵ洢�ռ䣬��ʹջ���ĵ�ַΪ__initial_sp��
                AREA    STACK, NOINIT, READWRITE, ALIGN=3 ;NOINIT�� = NO Init������ʼ����READWRITE : �ɶ�����д��ALIGN =3 : 2^3 ���룬��8�ֽڶ��롣
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
				bl LED_Init;bl�������ӵ���תָ���ʹ�ø�ָ����תʱ����ǰ��ַ(PC)���Զ�����LR�Ĵ���
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
                
                B MainLoop;B:��������ת��
LED_Init;LED��ʼ��
                PUSH {R0,R1, LR};R0,R1,LR�е�ֵ�����ջ
                
                LDR R0,=RCC_APB2ENR;LDR�ǰѵ�ַװ�ص��Ĵ�����(����R0)��
                ORR R0,R0,#0x1c;ORR ��λ�����,11100��R0�ĵڶ�λ��1������λ����
                LDR R1,=RCC_APB2ENR
                STR R0,[R1];STR�ǰ�ֵ�洢���Ĵ�����ָ�ĵ�ַ�У���r0��洢��ֵ��rcc�Ĵ���
				;����һ���ֻ������ǿ���ʱ�ӵ�
				
				
                ;��ʼ��GPIOA����
                LDR R0,=GPIOA_CRL
                BIC R0,R0,#0x0fffffff;BIC �Ȱ�������ȡ�����ٰ�λ��
                LDR R1,=GPIOA_CRL
                STR R0,[R1]
                ;����Ĵ����ǳ�ʼ��CPIOC_CRH
                LDR R0,=GPIOA_CRL
                ORR R0,#0x20000000;��������pc15��������2��Ϊ0100�����������ģʽ������ٶ�Ϊ2mhz
                LDR R1,=GPIOA_CRL
                STR R0,[R1]
				;GPIOC�Ķ˿����ø߼Ĵ���������ϣ�Ҳ����CPIOA_CRH������ɣ��˿ڵ����ģʽȷ������ʹ�õĶ���Ϊ��λ���״̬��Ϊ0100���������洦�����Ϊ����4
                ;��PC15��1
                MOV R0,#0x80; ������Ϊ0b1000 0000 ,��7λ����a7���ŵ������ѹ
                LDR R1,=GPIOA_ORD ;��r1����ord�Ĵ���
                STR R0,[R1] ;��ord�Ĵ�����ֵ��Ϊr0��ֵ
				
				 ;��ʼ��GPIOB����
                LDR R0,=GPIOB_CRH
                BIC R0,R0,#0xffffff0f;BIC �Ȱ�������ȡ�����ٰ�λ��,�õ���b9�����԰ѵڶ�λ����
                LDR R1,=GPIOB_CRH
                STR R0,[R1]
                ;����Ĵ����ǳ�ʼ��CPIOC_CRH
                LDR R0,=GPIOB_CRH
                ORR R0,#0x00000020;��������pc15��������2��Ϊ0100�����������ģʽ������ٶ�Ϊ2mhz
                LDR R1,=GPIOB_CRH
                STR R0,[R1]
				;GPIOC�Ķ˿����ø߼Ĵ���������ϣ�Ҳ����CPIOA_CRH������ɣ��˿ڵ����ģʽȷ������ʹ�õĶ���Ϊ��λ���״̬��Ϊ0100���������洦�����Ϊ����4
                ;��PC15��1
                MOV R0,#0x200; ������Ϊ0b10 0000 0000,��16λ����b9���ŵ������ѹ
                LDR R1,=GPIOB_ORD ;��r1����ord�Ĵ���
                STR R0,[R1] ;��ord�Ĵ�����ֵ��Ϊr0��ֵ
				
				 ;��ʼ��GPIOC����
                LDR R0,=GPIOC_CRH
                BIC R0,R0,#0x0fffffff;BIC �Ȱ�������ȡ�����ٰ�λ�룬���ǽ���ʮ��λȫ������
                LDR R1,=GPIOC_CRH
                STR R0,[R1]
                ;����Ĵ����ǳ�ʼ��CPIOC_CRH
                LDR R0,=GPIOC_CRH
                ORR R0,#0x20000000;��������pc15��������2��Ϊ0100�����������ģʽ������ٶ�Ϊ2mhz
                LDR R1,=GPIOC_CRH
                STR R0,[R1]
				;GPIOC�Ķ˿����ø߼Ĵ���������ϣ�Ҳ����CPIOA_CRH������ɣ��˿ڵ����ģʽȷ������ʹ�õĶ���Ϊ��λ���״̬��Ϊ0100���������洦�����Ϊ����4
                ;��PC15��1
                MOV R0,#0x8000; ������Ϊ0b1000 0000 0000 0000,��16λ����c15���ŵ������ѹ
                LDR R1,=GPIOC_ORD ;��r1����ord�Ĵ���
                STR R0,[R1] ;��ord�Ĵ�����ֵ��Ϊr0��ֵ
             
                POP {R0,R1,PC};��ջ��֮ǰ���R0��R1��LR��ֵ������R0��R1��PC
LED_ON_A;����
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x00 ;������Ϊ0b0000 0000 0000 0000����16λΪ0�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOA_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1];��r0��ֵ������GPIOC_ORD��
             
                POP {R0,R1,PC}
             
LED_OFF_A;Ϩ��
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x80 ;������Ϊ0b 1000 0000 0000 0000����16λΪ1�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOA_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1] ;[]��ָ������ĵ�ַ�����������ǽ�r0��ֵ����GPIOC_ORD
             
                POP {R0,R1,PC}  
LED_ON_B;����
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x000 ;������Ϊ0b0000 0000 0000 0000����16λΪ0�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOB_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1];��r0��ֵ������GPIOC_ORD��
             
                POP {R0,R1,PC}
             
LED_OFF_B;Ϩ��
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x200 ;������Ϊ0b 1000 0000 0000 0000����16λΪ1�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOB_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1] ;[]��ָ������ĵ�ַ�����������ǽ�r0��ֵ����GPIOC_ORD
             
                POP {R0,R1,PC}  
LED_ON_C;����
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x0000 ;������Ϊ0b0000 0000 0000 0000����16λΪ0�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOC_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1];��r0��ֵ������GPIOC_ORD��
             
                POP {R0,R1,PC}
             
LED_OFF_C;Ϩ��
                PUSH {R0,R1, LR}    
                
                MOV R0,#0x8000 ;������Ϊ0b 1000 0000 0000 0000����16λΪ1�����潫��Ϊpc15�������ѹ
                LDR R1,=GPIOC_ORD ;��GPIOC�ĵ�ַ����r1
                STR R0,[R1] ;[]��ָ������ĵ�ַ�����������ǽ�r0��ֵ����GPIOC_ORD
             
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
                BCC DelayLoop0 ;�޽�λ

                MOVS R0,#0
                MOVS R1,#0
                ADDS R2,R2,#1
                CMP R2,#15
                BCC DelayLoop0
                
                
                POP {R0,R1,PC}    
                NOP
				END