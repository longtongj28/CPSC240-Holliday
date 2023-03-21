#include <stdbool.h>

extern int compar(const void * a, const void * b);

int compar(const void * a, const void * b) {
    if (*(double*)a > *(double*)b)
        return 1;

    if (*(double*)a < *(double*)b)
        return -1;

    return 0;
}

/*
int compar(const void * a, const void * b) {
    if (*(Character*)a > *(Character*)b)
        return 1;

    if (*(Character*)a < *(Character*)b)
        return -1;

    return 0;
}
*/

/*
bool cmpfunc (const void * a, const void * b) {
   return ( *(int*)a < *(int*)b );
}
*/

// {1.2, -2.4}
// 1.2 -(-2.4) = 3.6