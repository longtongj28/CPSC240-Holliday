#include <stdio.h>

extern void outputoneline(int i, double sum, int n);
void outputoneline(int i, double sum, int n) {
    int step = n/10;
    if (i % step  == 0 || i >= n) {
        printf("%d                   %lf\n", i, sum);
    }
}