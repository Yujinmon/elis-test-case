/*
 * Branches for testing flow-sensitive analysis.
 * Author: Sen Ye
 * Date: 08/11/2013
 */

#include "aliascheck.h"
#include <stdlib.h>

int main(int argc, char* argv[]) {
	int *p, *q;
	int x = atoi(argv[1]);
	int y;
	
	q = &y;
	if (x) {
		p = &x;
		NOALIAS(p, q);
	}
	else {
		p = &y;
		MUSTALIAS(p, q);
	}
	return 0;
}
