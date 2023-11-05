#include <stdio.h>
int map[8][8];
int vis[8][8];	//标记已访问位置
int mx[4] = {0, 0, 1, -1};
int my[4] = {1, -1, 0, 0};
int n, m;
int x1, y1, x2, y2;
int res;
int a1, a2;
void dfs(int x, int y) {
	if (x == x2 && y == y2) {
		res++;
		return;
	}
	for (int i = 0; i < 4; i++) {
		int nx = x + mx[i], ny = y + my[i];
		if (nx >= 0 && nx < n && ny >= 0 && ny < m && vis[nx][ny] == 0 && map[nx][ny] == 0) {
			vis[nx][ny] = 1;
			a1 = nx, a2 = ny;
			dfs(a1, a2);
			vis[nx][ny] = 0;
		}
	}
}
int main() {
	scanf("%d %d", &n, &m);
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			scanf("%d", &map[i][j]);
		}
	}
	scanf("%d %d %d %d", &x1, &y1, &x2, &y2);
	x1 -= 1;
	y1 -= 1;
	x2 -= 1;
	y2 -= 1;
	vis[x1][y1] = 1;
	a1 = x1;
	a2 = y1;
	dfs(a1, a2);
	printf("%d", res);
	return 0;
}
