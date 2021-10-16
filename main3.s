 AREA main,CODE,READONLY
	import addf
	ENTRY
	EXPORT __main

__main
	mov r0,#10 ;给两个参数赋值
	mov r1,#12
	bl addf ;调用函数
	end