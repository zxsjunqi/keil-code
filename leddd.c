//--------------APB2ʹ��ʱ�ӼĴ���------------------------
#define RCC_AP2ENR	*((unsigned volatile int*)0x40021018)
	//----------------GPIOA���üĴ��� ------------------------
#define GPIOA_CRL	*((unsigned volatile int*)0x40010800)
#define	GPIOA_ORD	*((unsigned volatile int*)0x4001080C)
//----------------GPIOB���üĴ��� ------------------------
#define GPIOB_CRH	*((unsigned volatile int*)0x40010C04)
#define	GPIOB_ORD	*((unsigned volatile int*)0x40010C0C)
//----------------GPIOC���üĴ��� ------------------------
#define GPIOC_CRH	*((unsigned volatile int*)0x40011004)
#define	GPIOC_ORD	*((unsigned volatile int*)0x4001100C)
//-------------------�򵥵���ʱ����-----------------------
void  Delay_ms( volatile  unsigned  int  t)
{
     unsigned  int  i;
     while(t--)
         for (i=0;i<800;i++);
}
void A_LED_LIGHT(){
	GPIOA_ORD=0x0<<7;		//PA7�͵�ƽ
	GPIOB_ORD=0x1<<9;		//PB9�ߵ�ƽ
	GPIOC_ORD=0x1<<15;		//PC15�ߵ�ƽ
}
void B_LED_LIGHT(){
	GPIOA_ORD=0x1<<7;		//PA7�ߵ�ƽ
	GPIOB_ORD=0x0<<9;		//PB9�͵�ƽ
	GPIOC_ORD=0x1<<15;		//PC15�ߵ�ƽ
}
void C_LED_LIGHT(){
	GPIOA_ORD=0x1<<7;		//PA7�ߵ�ƽ
	GPIOB_ORD=0x1<<9;		//PB9�ߵ�ƽ
	GPIOC_ORD=0x0<<15;		//PC15�͵�ƽ	
}
//------------------------������--------------------------
int main()
{
	int j=100;
	RCC_AP2ENR|=1<<2;			//APB2-GPIOA����ʱ��ʹ��
	RCC_AP2ENR|=1<<3;			//APB2-GPIOB����ʱ��ʹ��	
	RCC_AP2ENR|=1<<4;			//APB2-GPIOC����ʱ��ʹ��
	//�����д�����Ժ�Ϊ RCC_APB2ENR|=1<<3|1<<4;
	GPIOA_CRL&=0x0FFFFFFF;		//����λ ����	
	GPIOA_CRL|=0x20000000;		//PA7�������
	GPIOA_ORD|=1<<7;			//����PA7��ʼ��Ϊ��
	
	GPIOB_CRH&=0xFFFFFF0F;		//����λ ����	
	GPIOB_CRH|=0x00000020;		//PB9�������
	GPIOB_ORD|=1<<9;			//���ó�ʼ��Ϊ��
	
	GPIOC_CRH&=0x0FFFFFFF;		//����λ ����
	GPIOC_CRH|=0x30000000;   	//PC15�������
	GPIOC_ORD|=0x1<<15;			//���ó�ʼ��Ϊ��	
	while(j)
	{	
		A_LED_LIGHT();	
		Delay_ms(10000000);
		B_LED_LIGHT();
		Delay_ms(10000000);
		C_LED_LIGHT();
		Delay_ms(10000000);
	}
}

