#include<stdio.h>

int main() {
	int n, temp = 0;
	scanf("%d", &n);
	int arr[n];
	for(int i=0; i<n; i++) {
		scanf("%d", &arr[i]);
		if(temp < arr[i]) {
			temp = arr[i];
		}
	}
	for(int i=0; i<temp; i++) {
		int sum = 0;
		for(int j=0; j<n; j++) {
			if(arr[j] > 0) {
				sum++;
				arr[j]--;
			}
		}
		printf("%d ", sum);
	}
}
