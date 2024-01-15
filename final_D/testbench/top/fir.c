#include "fir.h"
#include <defs.h>

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
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

	inputsignal = inputdata[i];
	while(i < 63){
		
		ans[i] = outputsignal;
		i++;
		inputsignal = inputdata[i];
	}
	ans[i] = outputsignal;
	s = status;
	reg_mprj_datal = 0xFF5A0000;

	return ans;
}

// int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
// 	int s;
// 	int i = 0;
// 	initfir();
// 	//write down your fir
// 	inputsignal = i + 0;
// 	inputsignal = i + 1;
// 	inputsignal = i + 2;
// 	inputsignal = i + 3;
// 	// inputsignal = i + 4;
// 	// inputsignal = i + 5;
// 	// inputsignal = i + 6;
// 	// inputsignal = i + 7;
// 	while(i < 60){
// 		ans[i] = outputsignal;
// 		ans[i+1] = outputsignal;
// 		ans[i+2] = outputsignal;
// 		ans[i+3] = outputsignal;
// 		// ans[i+4] = outputsignal;
// 		// ans[i+5] = outputsignal;
// 		// ans[i+6] = outputsignal;
// 		// ans[i+7] = outputsignal;

// 		i = i + 4;
// 		inputsignal = i + 0;
// 		inputsignal = i + 1;
// 		inputsignal = i + 2;
// 		inputsignal = i + 3;
// 		// inputsignal = i + 4;
// 		// inputsignal = i + 5;
// 		// inputsignal = i + 6;
// 		// inputsignal = i + 7;
// 	}
// 	ans[i] = outputsignal;
// 	ans[i+1] = outputsignal;
// 	ans[i+2] = outputsignal;
// 	ans[i+3] = outputsignal;
// 	// ans[i+4] = outputsignal;
// 	// ans[i+5] = outputsignal;
// 	// ans[i+6] = outputsignal;
// 	// ans[i+7] = outputsignal;

// 	// for(i = 0;i<64;i=i+4){
// 	// 	inputsignal = i + 0;
// 	// 	inputsignal = i + 1;
// 	// 	inputsignal = i + 2;
// 	// 	inputsignal = i + 3;
// 	// 	ans[i] = outputsignal;
// 	// 	ans[i+1] = outputsignal;
// 	// 	ans[i+2] = outputsignal;
// 	// 	ans[i+3] = outputsignal;
// 	// }

// 	// reg_mprj_datal = ans[63];
	
// 	s = status;
// 	// reg_mprj_datal = ((0x000000FF & ans[63]) << 24) | 0x005A0000;
// 	reg_mprj_datal = 0xFF5A0000;

// 	return ans;
// }