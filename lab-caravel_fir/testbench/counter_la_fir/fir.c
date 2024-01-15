#include "fir.h"
#include <defs.h>

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	// initial your fir
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
	r_start_addr = 0x38002000;
	w_start_addr = 0x38002104;

	reg_mprj_datal = 0x00A50000;
	status = 0x00000001;
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	int s;
	int i = 0;
	initfir();

	// when config fir engine start, the fir engine will 
	// start asking data from user_BRAM through DMA,
	// Once here reveives the done status means end of computing.
	s = status;
	while(!((s >> 1) & 1)) {
		s = status;
	}

	// write down your fir
	// inputsignal = inputdata[i];
	// while(i < 63){
		
	// 	ans[i] = outputsignal;
	// 	i++;
	// 	inputsignal = inputdata[i];
	// }
	// ans[i] = outputsignal;
	// s = status;
	// reg_mprj_datal = ((0x000000FF & ans[63]) << 24) | 0x005A0000;
	reg_mprj_datal = 0xFF5A0000;

	return ans;
}
		
