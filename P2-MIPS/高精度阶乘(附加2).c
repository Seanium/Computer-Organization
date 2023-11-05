#include <stdio.h>
#define MAXN 1500
int A[MAXN], n, len, jinwei;
int main() {
	scanf("%d", &n);
	A[0] = 1;
	for (int i = 2; i <= n; i++) {
		jinwei = 0;
		for (int j = 0; j <= len + 4; j++) {     //假设每一次位数都增加4
			int t3 = A[j] * i + jinwei;       //先将这一位相乘，在进位
			jinwei = t3 / 10;
			A[j] = t3 % 10;
		}
		len = len + 4;
		//删除前导零 得到了真正的位数
		for (int k = len; k > 0; k--) {
			if (A[k] == 0) {
				len--;
			} else {
				break;
			}
		}
//		while (len > 0)  {
//			if (A[len] == 0) {
//				len--;
//			} else {
//				break;
//			}
//		}

	}
	//最后再删除一遍前导零，和上面一样
	for (int k = len; k > 0; k--) {
		if (A[k] == 0) {
			len--;
		} else {
			break;
		}
	}

	for (int i = len; i >= 0; i--) {
		printf("%d", A[i]);
	}
	return 0;
}
