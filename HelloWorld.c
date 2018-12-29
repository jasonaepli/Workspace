#include <stdio.h>

void main(){
	int i = 1;	
	int num;

	printf("Pick a number between 1 and 10 (inclusive).\n");
	scanf(num);

	while(i<=num){

	printf("Hello World! %i\n",i);
	i++;
	}

}
