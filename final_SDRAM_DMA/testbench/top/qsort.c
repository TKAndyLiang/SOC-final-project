#include "qsort.h"

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
