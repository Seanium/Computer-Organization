#include <stdio.h>
#define MAXN 1500
int A[MAXN], n, len, jinwei;
int main() {
	scanf("%d", &n);
	A[0] = 1;
	for (int i = 2; i <= n; i++) {
		jinwei = 0;
		for (int j = 0; j <= len + 4; j++) {     //����ÿһ��λ��������4
			int t3 = A[j] * i + jinwei;       //�Ƚ���һλ��ˣ��ڽ�λ
			jinwei = t3 / 10;
			A[j] = t3 % 10;
		}
		len = len + 4;
		//ɾ��ǰ���� �õ���������λ��
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
	//�����ɾ��һ��ǰ���㣬������һ��
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
