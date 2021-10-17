#include "bsp_uart.h"

void DEBUG_UART_Config(void)
{
	/*第一步：初始化GPIO*/
	//定义GPIO对象
	GPIO_InitTypeDef GPIO_InitStructure;
	//定义串口对象
	USART_InitTypeDef USART_InitStructure;
	//打开串口GPIO的时钟
	DEBUG_USART_GPIO_APBxClkCmd(DEBUG_USART_GPIO_CLK,ENABLE);
	//将USART Tx（发送数据）的GPIO的配置为推挽复用模式
	GPIO_InitStructure.GPIO_Pin=DEBUG_USART_TX_GPIO_PIN;
	GPIO_InitStructure.GPIO_Mode=GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Speed=GPIO_Speed_50MHz;
	GPIO_Init(DEBUG_USART_TX_GPIO_PORT,&GPIO_InitStructure);
	//将USART Rx（接收数据）的GPIO配置为浮空输入模式
	GPIO_InitStructure.GPIO_Pin=DEBUG_USART_RX_GPIO_PIN;
	GPIO_InitStructure.GPIO_Mode=GPIO_Mode_IN_FLOATING;
	GPIO_Init(DEBUG_USART_RX_GPIO_PORT,&GPIO_InitStructure);
	
	/*第二步：配置串口的初始化结构体*/
	//打开串口外设的时钟
	DEBUG_USART_APBxClkCmd(DEBUG_USART_CLK,ENABLE);
	//配置波特率
	USART_InitStructure.USART_BaudRate=DEBUG_USART_BAUDRATE;
	//配置数据字长
	USART_InitStructure.USART_WordLength=USART_WordLength_8b;
	//配置停止位
	USART_InitStructure.USART_StopBits=USART_StopBits_1;
	//配置校验位
	USART_InitStructure.USART_Parity=USART_Parity_No;
	//配置硬件流控制
	USART_InitStructure.USART_HardwareFlowControl=USART_HardwareFlowControl_None;
	//配置工作模式，采用收发一起，即可接收数据，也可发送数据
	USART_InitStructure.USART_Mode=USART_Mode_Rx | USART_Mode_Tx;
	//串口的初始化配置
	USART_Init(DEBUG_USARTx,&USART_InitStructure);
	/*第三步：使能串口*/
	USART_Cmd(DEBUG_USARTx,ENABLE);
}
