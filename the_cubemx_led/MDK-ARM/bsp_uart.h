#ifndef _BSP_UART_H
#define _BSP_UART_H

#include "stm32f10x.h"
//����1-USART1
#define DEBUG_UARTx										USART1;
#define DEBUG_UART_CLK      					RCC_APB2Periph_USART1
#define DEBUG_UART_APBxClkCmd					RCC_APB2PeriphClockCmd
#define DEBUG_UART_BAUDRATE						115200

//USART GPIO ���ź궨��
#define DEBUG_USART_GPIO_CLK				  (RCC_APB2Periph_GPIOA)
#define DEBUG_USART_GPIO_APBxClkCmd		RCC_APB2PeriphClockCmd
#define DEBUG_USART_TX_GPIO_PORT			GPIOA
#define DEBUG_USART_TX_GPIO_PIN       GPIO_Pin_9
#define DEBUG_USART_RX_GPIO_PORT			GPIOA
#define DEBUG_USART_RX_GPIO_PIN				GPIO_Pin_10

#define DEBUG_USART_IRQ								USART1_IRQn
#define DEBUG_USART_IRQHandler				USART1_IRQHandler
void DEBUG_UART_Config(void);

#endif /*_BSP_UART_H*/

