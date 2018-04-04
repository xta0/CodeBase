#include "main.h" 
#include "module1.h"
#include "module2.h"

int main(void){

	printf("hello world");
	int ret1 = module_1_Func(100,20); 
	printf("\n%d\n",ret1);
	
    int ret2 = module_2_Func(200,100);
	printf("\n%d\n",ret2);
	return 0;
}