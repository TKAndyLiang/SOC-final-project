#include <defs.h>
#include <user_uart.h>
#include <irq_vex.h>
#include "function.h"



void __attribute__ ( ( section ( ".mprj" ) ) ) uart_write(int n)
{
    while(((reg_uart_stat>>3) & 1));
    reg_tx_data = n;
}

void __attribute__ ( ( section ( ".mprj" ) ) ) uart_write_char(char c)
{
	if (c == '\n')
		uart_write_char('\r');

    // wait until tx_full = 0
    while(((reg_uart_stat>>3) & 1));
    reg_tx_data = c;
}

void __attribute__ ( ( section ( ".mprj" ) ) ) uart_write_string(const char *s)
{
    while (*s)
        uart_write_char(*(s++));
}


char __attribute__ ( ( section ( ".mprj" ) ) ) uart_read_char()
{
	char num;
    if((((reg_uart_stat>>5) | 0) == 0) && (((reg_uart_stat>>4) | 0) == 0)){
        for(int i = 0; i < 1; i++)
            asm volatile ("nop");

        num = reg_rx_data;
    }

    return num;
}

int __attribute__ ( ( section ( ".mprj" ) ) ) uart_read()
{
    int num;
    if((((reg_uart_stat>>5) | 0) == 0) && (((reg_uart_stat>>4) | 0) == 0)){
        for(int i = 0; i < 1; i++)
            asm volatile ("nop");

        num = reg_rx_data;
    }

    return num;
}


int* __attribute__ ( ( section ( ".mprjram" ) ) ) matmul()
{
	int i;
	int j;
	int k;
	int sum;
	for (i=0; i<SIZE; i++){
		for (j=0; j<SIZE; j++){
			sum = 0;
			for(k = 0;k<SIZE;k++)
				sum += A[(i*SIZE) + k] * B[(k*SIZE) + j];
			result[(i*SIZE) + j] = sum;
		}
	}
	return result;
}




int __attribute__ ( ( section ( ".mprjram" ) ) ) partition(int low,int hi){
	int pivot = QS[hi];
	int i = low-1,j;
	int temp;
	for(j = low;j<hi;j++){
		if(QS[j] < pivot){
			i = i+1;
			temp = QS[i];
			QS[i] = QS[j];
			QS[j] = temp;
		}
	}
	if(QS[hi] < QS[i+1]){
		temp = QS[i+1];
		QS[i+1] = QS[hi];
		QS[hi] = temp;
	}
	return i+1;
}
void __attribute__ ( ( section ( ".mprjram" ) ) ) sort(int low, int hi){
	if(low < hi){
		int p = partition(low, hi);
		sort(low,p-1);
		sort(p+1,hi);
	}
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) qsort(){
	sort(0,SIZE_QS-1);
	return QS;
}


void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir
	// {0,-10,-9,23,56,63,56,23,-9,-10,0};
	tap_1 = 0;
	tap_2 = -10;
	tap_3 = -9;
	tap_4 = 23;
	tap_5 = 56;
	tap_6 = 63;
	tap_7 = 56;
	tap_8 = 23;
	tap_9 = -9;
	tap_10= -10;
	tap_11= 0;

	datalength = 64;

	reg_mprj_datal = 0x00A50000;
	status = 0x00000001;

}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	int s;
	int i = 0;
	initfir();
	//write down your fir
	inputsignal = inputdata[i];
	// inputsignal = inputdata[i+1];
	// inputsignal = inputdata[i+2];
	// inputsignal = inputdata[i+3];
	
	// inputsignal = inputdata[i+4];
	// inputsignal = inputdata[i+5];
	// inputsignal = inputdata[i+6];
	// inputsignal = inputdata[i+7];
	// inputsignal = i + 0;
	// inputsignal = i + 1;
	// inputsignal = i + 2;
	// inputsignal = i + 3;
	// inputsignal = i + 4;
	// inputsignal = i + 5;
	// inputsignal = i + 6;
	// inputsignal = i + 7;
	while(i < 63){
		ans[i] = outputsignal;
		// ans[i+1] = outputsignal;
		// ans[i+2] = outputsignal;
		// ans[i+3] = outputsignal;
		// ans[i+4] = outputsignal;
		// ans[i+5] = outputsignal;
		// ans[i+6] = outputsignal;
		// ans[i+7] = outputsignal;

		i = i + 1;
		inputsignal = inputdata[i];
		// inputsignal = inputdata[i+1];
		// inputsignal = inputdata[i+2];
		// inputsignal = inputdata[i+3];
		// inputsignal = inputdata[i+4];
		// inputsignal = inputdata[i+5];
		// inputsignal = inputdata[i+6];
		// inputsignal = inputdata[i+7];
		// inputsignal = i + 0;
		// inputsignal = i + 1;
		// inputsignal = i + 2;
		// inputsignal = i + 3;
		// inputsignal = i + 4;
		// inputsignal = i + 5;
		// inputsignal = i + 6;
		// inputsignal = i + 7;
	}
	ans[i] = outputsignal;
	// ans[i+1] = outputsignal;
	// ans[i+2] = outputsignal;
	// ans[i+3] = outputsignal;
	// ans[i+4] = outputsignal;
	// ans[i+5] = outputsignal;
	// ans[i+6] = outputsignal;
	// ans[i+7] = outputsignal;

	// for(i = 0;i<64;i=i+4){
	// 	inputsignal = i + 0;
	// 	inputsignal = i + 1;
	// 	inputsignal = i + 2;
	// 	inputsignal = i + 3;
	// 	ans[i] = outputsignal;
	// 	ans[i+1] = outputsignal;
	// 	ans[i+2] = outputsignal;
	// 	ans[i+3] = outputsignal;
	// }

	// reg_mprj_datal = ans[63];
	
	s = status;
	// reg_mprj_datal = ((0x000000FF & ans[63]) << 24) | 0x005A0000;
	reg_mprj_datal = 0xFF5A0000;

	return ans;
}