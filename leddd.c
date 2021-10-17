//--------------APB2使能时钟寄存器------------------------
#define RCC_AP2ENR	*((unsigned volatile int*)0x40021018)
	//----------------GPIOA配置寄存器 ------------------------
#define GPIOA_CRL	*((unsigned volatile int*)0x40010800)
#define	GPIOA_ORD	*((unsigned volatile int*)0x4001080C)
//----------------GPIOB配置寄存器 ------------------------
#define GPIOB_CRH	*((unsigned volatile int*)0x40010C04)
#define	GPIOB_ORD	*((unsigned volatile int*)0x40010C0C)
//----------------GPIOC配置寄存器 ------------------------
#define GPIOC_CRH	*((unsigned volatile int*)0x40011004)
#define	GPIOC_ORD	*((unsigned volatile int*)0x4001100C)
//-------------------简单的延时函数-----------------------
void  Delay_ms( volatile  unsigned  int  t)
{
     unsigned  int  i;
     while(t--)
         for (i=0;i<800;i++);
}
void A_LED_LIGHT(){
	GPIOA_ORD=0x0<<7;		//PA7低电平
	GPIOB_ORD=0x1<<9;		//PB9高电平
	GPIOC_ORD=0x1<<15;		//PC15高电平
}
void B_LED_LIGHT(){
	GPIOA_ORD=0x1<<7;		//PA7高电平
	GPIOB_ORD=0x0<<9;		//PB9低电平
	GPIOC_ORD=0x1<<15;		//PC15高电平
}
void C_LED_LIGHT(){
	GPIOA_ORD=0x1<<7;		//PA7高电平
	GPIOB_ORD=0x1<<9;		//PB9高电平
	GPIOC_ORD=0x0<<15;		//PC15低电平	
}
//------------------------主函数--------------------------
int main()
{
	int j=100;
	RCC_AP2ENR|=1<<2;			//APB2-GPIOA外设时钟使能
	RCC_AP2ENR|=1<<3;			//APB2-GPIOB外设时钟使能	
	RCC_AP2ENR|=1<<4;			//APB2-GPIOC外设时钟使能
	//这两行代码可以合为 RCC_APB2ENR|=1<<3|1<<4;
	GPIOA_CRL&=0x0FFFFFFF;		//设置位 清零	
	GPIOA_CRL|=0x20000000;		//PA7推挽输出
	GPIOA_ORD|=1<<7;			//设置PA7初始灯为灭
	
	GPIOB_CRH&=0xFFFFFF0F;		//设置位 清零	
	GPIOB_CRH|=0x00000020;		//PB9推挽输出
	GPIOB_ORD|=1<<9;			//设置初始灯为灭
	
	GPIOC_CRH&=0x0FFFFFFF;		//设置位 清零
	GPIOC_CRH|=0x30000000;   	//PC15推挽输出
	GPIOC_ORD|=0x1<<15;			//设置初始灯为灭	
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

