   
void  Delay_ms( volatile  unsigned  int  t)
{
     unsigned  int  i,n;
     for (n=0;n<t;n++)
         for (i=0;i<800;i++);
}
int main(void)
    {
        unsigned int *RCC_AP2ENR = (unsigned int *)0x40021018;
        unsigned int *pGPIOB_CRH_9 = (unsigned int *)0x40010c04;
        unsigned int *pGPIOB_ODR_9;
				pGPIOB_ODR_9= (unsigned int *)0x40010c0c;
			
        unsigned int *pGPIOA_CRH_8 = (unsigned int *)0x40010804;
        unsigned int *pGPIOA_ODR_8;
			   pGPIOA_ODR_8= (unsigned int *)0x4001080c;
			
        unsigned int *pGPIOC_CRH_15 = (unsigned int *)0x40011004;
        unsigned int *pGPIOC_ODR_15 ;
				pGPIOC_ODR_15= (unsigned int *)0x4001100c;
        *RCC_AP2ENR = 0xff;//控制时钟
        *pGPIOB_CRH_9 = 0x44444424;
        *pGPIOB_ODR_9 = 0x00000000;

				//*pGPIOA_CRH_8 = 0x44444442;
        //*pGPIOA_ODR_8 = 0x00000000;

				*pGPIOC_CRH_15 = 0x24444444;
        *pGPIOC_ODR_15 = 0x00000000;
			while(1){
				Delay_ms(1000);
				*pGPIOB_ODR_9=();
				Delay_ms(1000);
				*pGPIOB_ODR_9=0x00000000;
				*pGPIOC_ODR_15=0xffffffff;

			}             
    }
		
		//GPIOA_ORD=0<<7;		//PA7低电平
		//delay(10000);
		//GPIOA_ORD=1<<7;		//PA7高电平
	 	//delay(10000);
		
		//GPIOB_ORD=0<<9;		//PB9低电平
		//delay(10000);
		//GPIOB_ORD=1<<9;		//PB9高电平
	 	//delay(10000);

