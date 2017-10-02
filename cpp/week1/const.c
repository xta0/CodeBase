#include <stdio.h>
#include <string.h>

void myPrint(const char* p)
{
	//*p = "this";//compile error!
}

inline int max(int a, int b)
{
	if(a>b)
		return a;
	else
		return b;
}

int max(int a,int b, int c)
{
	return 0;


}

int max(double f1, double f2)
{
	return 0;

}

int main(int argc, char** argv)
{

	int n = 100;
	int m = 101;
	const int* p1 = &n;
	int *p2 = &m;

	//*p1 = 100; //compile error!
	p1 = p2; //ok

	printf("%d\n",*p1 ); //101

	//p2 = p1; //compile error!

	p2 = (int* )p1; //ok

	int x = max(1,2);
	

	return 0;
}