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

// int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
// 	int s;
// 	int i = 0;
// 	initfir();

// 	inputsignal = inputdata[i];
// 	while(i < 63){
		
// 		ans[i] = outputsignal;
// 		i++;
// 		inputsignal = inputdata[i];
// 	}
// 	ans[i] = outputsignal;
// 	s = status;
// 	reg_mprj_datal = 0xFF5A0000;

// 	return ans;
// }

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	int s;
	int i = 0;
	initfir();
	//write down your fir
	inputsignal = inputdata[i + 0];
	// inputsignal = inputdata[i + 1];
	// inputsignal = inputdata[i + 2];
	// inputsignal = inputdata[i + 3];
	// inputsignal = inputdata[i + 4];
	// inputsignal = inputdata[i + 5];
	// inputsignal = inputdata[i + 6];
	// inputsignal = inputdata[i + 7];
	// inputsignal = inputdata[i + 8];
	// inputsignal = inputdata[i + 9];
	// inputsignal = inputdata[i + 10];
	// inputsignal = inputdata[i + 11];
	// inputsignal = inputdata[i + 12];
	// inputsignal = inputdata[i + 13];
	// inputsignal = inputdata[i + 14];
	// inputsignal = inputdata[i + 15];
	// inputsignal = i + 4;
	// inputsignal = i + 5;
	// inputsignal = i + 6;
	// inputsignal = i + 7;
	while(i < (64-1)){
		ans[i] = outputsignal;
		// ans[i+1] = outputsignal;
		// ans[i+2] = outputsignal;
		// ans[i+3] = outputsignal;
		// ans[i+4] = outputsignal;
		// ans[i+5] = outputsignal;
		// ans[i+6] = outputsignal;
		// ans[i+7] = outputsignal;
		// ans[i+8] = outputsignal;
		// ans[i+9] = outputsignal;
		// ans[i+10] = outputsignal;
		// ans[i+11] = outputsignal;
		// ans[i+12] = outputsignal;
		// ans[i+13] = outputsignal;
		// ans[i+14] = outputsignal;
		// ans[i+15] = outputsignal;
		i = i + 1;
		inputsignal = inputdata[i + 0];
		// inputsignal = inputdata[i + 1];
		// inputsignal = inputdata[i + 2];
		// inputsignal = inputdata[i + 3];
		// inputsignal = inputdata[i + 4];
		// inputsignal = inputdata[i + 5];
		// inputsignal = inputdata[i + 6];
		// inputsignal = inputdata[i + 7];
		// inputsignal = inputdata[i + 8];
		// inputsignal = inputdata[i + 9];
		// inputsignal = inputdata[i + 10];
		// inputsignal = inputdata[i + 11];
		// inputsignal = inputdata[i + 12];
		// inputsignal = inputdata[i + 13];
		// inputsignal = inputdata[i + 14];
		// inputsignal = inputdata[i + 15];
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
	// ans[i+8] = outputsignal;
	// ans[i+9] = outputsignal;
	// ans[i+10] = outputsignal;
	// ans[i+11] = outputsignal;
	// ans[i+12] = outputsignal;
	// ans[i+13] = outputsignal;
	// ans[i+14] = outputsignal;
	// ans[i+15] = outputsignal;
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