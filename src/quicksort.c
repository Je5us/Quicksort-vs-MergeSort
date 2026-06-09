#include "sort.h"

static void swapInt(int *a, int *b){
  int tmp = *a;
  *a = *b;
  *b = tmp;
}

static int partition(int arr[], int left, int right){
  /*
   * TODO: complete la partición de quicksort.
   * Sugerencia mínima:
   * 1. Use arr[right] como pivote.
   * 2. Mantenga a la izquierda los elementos <= pivote.
   * 3. Devuelva la posición final del pivote.
   */
	int pivot = right; 
	int i = right - 1;
	int j = right;
	
	while(i >= left){
		if(arr[i] > pivot)
			swapInt(&arr[i], &arr[j]);
		i--;
	}
	swapInt(&arr[right], &arr[j]);
  return j;
}

static void quickSortRange(int arr[], int left, int right){
  if(left >= right)
    return;

  int pivotIndex = partition(arr, left, right);
  quickSortRange(arr, left, pivotIndex - 1);
  quickSortRange(arr, pivotIndex + 1, right);
}

void quickSort(int arr[], int n){
  if(n <= 1)
    return;
  quickSortRange(arr, 0, n - 1);
}

