#include <stdio.h>

extern void outputoneline(int i, double sum, int n);
void outputoneline(int i, double sum, int n) {
    if (i % 84 == 0) {
        printf("%d                   %lf\n", i, sum);
    }
    if (i >= n) {
        printf("%d                   %lf\n", n, sum);
    }
}