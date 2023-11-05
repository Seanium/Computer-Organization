//#include<stdio.h>
//int symbol[7], array[7];
//int n;
//void FullArray(int index) {
//	if (index >= n) {
//		for (int i = 0; i < n; i++) {
//			printf("%d ", array[i]);
//		}
//		printf("\n");
//		return;
//	}
//	for (int i = 0; i < n; i++) {
//		if (symbol[i] == 0) {
//			array[index] = i + 1;
//			symbol[i] = 1;
//			FullArray(index+1);
//			symbol[i] = 0;
//		}
//	}
//}
//int main() {
//	scanf("%d", &n);
//	FullArray(0);
//	return 0;
//}

#include<stdio.h>
int symbol[7], array[7];
int n;
int a1 = 0;
void FullArray(int t8) {
	if (t8 >= n) {
		for (int j = 0; j < n; j++) {
			printf("%d ", array[j]);
		}
		printf("\n");
		return;
	}
	for (int i = 0; i < n; i++) {
		if (symbol[i] == 0) {
			array[t8] = i + 1;
			symbol[i] = 1;
			a1 = t8 + 1;
			FullArray(a1);
			symbol[i] = 0;
		}
	}
}
int main() {
	scanf("%d", &n);
	FullArray(0);
	return 0;
}

