#include <iostream>
using namespace std;
//https://www.quora.com/How-do-I-divide-two-numbers-using-only-bit-operations-in-Java

int add(int a, int b)
{
    while(b!=0){

    }
    int partialSum, carry;
    do{
        cout<<"a: "<<a<<", b: "<<b<<endl;
        partialSum = a ^ b;
        carry = (a & b) << 1;
        a = partialSum;
        b = carry;
        cout<<"a: "<<a<<", b: "<<b<<endl;
        
    } while (carry != 0);
    return partialSum;
}

int main()
{
    int a=1;
    int b=3;
    cout<<(a^b)<<","<<(a|b)<<", "<<(~a)<<endl;

    while(true){
        int a,b;
        cin>>a>>b;
        if(a==0&b==0){
            break;
        }else{
            add(a,b);
        }
    }
    
    return 0;
}