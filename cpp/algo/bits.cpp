#include <iostream>
using namespace std;

int add(int a, int b)
{
    int partialSum, carry;
    do{
        partialSum = a ^ b;
        carry = (a & b) << 1;
        a = partialSum;
        b = carry; 
    } while (carry != 0);
    return partialSum;
}
int substract(int a, int b){

    return add(a,add(~b,1));
}
int multiply(int a, int b){
    int x = a < 0 ? add(~a, 1) : a; //取绝对值
    int y = b < 0 ? add(~b, 1) : b; //取绝对值
    
    int result = 0;
    while(y){
        if(x&0x01){
            result = add(result,x);
        }
        x<<1;
        y>>1;
    }
    if((a^b)<0){
        result = add(~result,1);
    }
    return result;

}
int divide(int a, int b){
    int dividend = a < 0 ? add(~a, 1) : a; //取绝对值
    int divisor = b < 0 ? add(~b, 1) : b; //取绝对值
    int remainder = dividend;
    int result = 0;
    while(remainder >= divisor){
        remainder = substract(remainder,divisor);
        result = add(result,1);
    }
    if((a^b)<0){
        result = add(~result,1);
    }
    return result;
}
int main()
{
    int a=2; int b=-11;
    cout<<add(~b,1)<<endl;
    cout<<substract(3,5)<<endl;
    cout<<multiply(2,3)<<endl;
    cout<<divide(7,3)<<endl;


    return 0;
}