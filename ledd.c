   
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
        unsigned int *pGPIOC_ODR_15 
				pGPIOC_ODR_15= (unsigned int *)0x4001100c;
        *RCC_AP2ENR = 0xa;//¿ØÖÆÊ±ÖÓ
        *pGPIOB_CRH_9 = 0x44444424;
        *pGPIOB_ODR_9 = 0x00000000;

				//*pGPIOA_CRH_8 = 0x44444442;
        //*pGPIOA_ODR_8 = 0x00000000;

				*pGPIOC_CRH_15 = 0x24444444;
        *pGPIOC_ODR_15 = 0x00000000;
			while(0){
				Delay_ms(1000);
				*pGPIOB_ODR_9=0xffffffff;
				*pGPIOC_ODR_15=0x00000000;
				Delay_ms(1000);
				*pGPIOB_ODR_9=0x00000000;
				*pGPIOC_ODR_15=0xffffffff;

			}             
    }

