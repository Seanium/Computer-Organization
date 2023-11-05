#include <stdio.h>
int A[10][10], B[10][10], C[10][10];
int main() {
	int m1, n1, m2, n2;
	scanf("%d", &m1);
	scanf("%d", &n1);
	scanf("%d", &m2);
	scanf("%d", &n2);
	int m3 = m1 - m2 + 1;
	int n3 = n1 - n2 + 1;
	for (int i = 0; i < m1; i++) {
		for (int j = 0; j < n1; j++) {
			scanf("%d", &A[i][j]);
		}
	}
	for (int i = 0; i < m2; i++) {
		for (int j = 0; j < n2; j++) {
			scanf("%d", &B[i][j]);
		}
	}
	for (int i = 0; i < m3; i++) {
		for (int j = 0; j < n3; j++) {
			for (int k = 0; k < m2; k++) {
				for (int l = 0; l < n2; l++) {
					C[i][j] += A[i + k][j + l] * B[k][l];
				}
			}
		}
	}
	for (int i = 0; i < m3; i++) {
		for (int j = 0; j < n3; j++) {
			printf("%d ", C[i][j]);
		}
		printf("\n");
	}
	return 0;
}
