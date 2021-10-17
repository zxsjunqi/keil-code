#include "bsp_uart.h"

void DEBUG_UART_Config(void)
{
	/*��һ������ʼ��GPIO*/
	//����GPIO����
	GPIO_InitTypeDef GPIO_InitStructure;
	//���崮�ڶ���
	USART_InitTypeDef USART_InitStructure;
	//�򿪴���GPIO��ʱ��
	DEBUG_USART_GPIO_APBxClkCmd(DEBUG_USART_GPIO_CLK,ENABLE);
	//��USART Tx���������ݣ���GPIO������Ϊ���츴��ģʽ
	GPIO_InitStructure.GPIO_Pin=DEBUG_USART_TX_GPIO_PIN;
	GPIO_InitStructure.GPIO_Mode=GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Speed=GPIO_Speed_50MHz;
	GPIO_Init(DEBUG_USART_TX_GPIO_PORT,&GPIO_InitStructure);
	//��USART Rx���������ݣ���GPIO����Ϊ��������ģʽ
	GPIO_InitStructure.GPIO_Pin=DEBUG_USART_RX_GPIO_PIN;
	GPIO_InitStructure.GPIO_Mode=GPIO_Mode_IN_FLOATING;
	GPIO_Init(DEBUG_USART_RX_GPIO_PORT,&GPIO_InitStructure);
	
	/*�ڶ��������ô��ڵĳ�ʼ���ṹ��*/
	//�򿪴��������ʱ��
	DEBUG_USART_APBxClkCmd(DEBUG_USART_CLK,ENABLE);
	//���ò�����
	USART_InitStructure.USART_BaudRate=DEBUG_USART_BAUDRATE;
	//���������ֳ�
	USART_InitStructure.USART_WordLength=USART_WordLength_8b;
	//����ֹͣλ
	USART_InitStructure.USART_StopBits=USART_StopBits_1;
	//����У��λ
	USART_InitStructure.USART_Parity=USART_Parity_No;
	//����Ӳ��������
	USART_InitStructure.USART_HardwareFlowControl=USART_HardwareFlowControl_None;
	//���ù���ģʽ�������շ�һ�𣬼��ɽ������ݣ�Ҳ�ɷ�������
	USART_InitStructure.USART_Mode=USART_Mode_Rx | USART_Mode_Tx;
	//���ڵĳ�ʼ������
	USART_Init(DEBUG_USARTx,&USART_InitStructure);
	/*��������ʹ�ܴ���*/
	USART_Cmd(DEBUG_USARTx,ENABLE);
}
