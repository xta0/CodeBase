#include <iostream>
using namespace std;
//https://www.quora.com/How-do-I-divide-two-numbers-using-only-bit-operations-in-Java

int add(int a, int b)
{
    int partialSum, carry;
    do
    {
        cout<<"a: "<<a;
        cout<<"b: "<<b;
        partialSum = a ^ b;
        carry = (a & b) << 1;
        a = partialSum;
        b = carry;
        
    } while (carry != 0);
    return partialSum;
}

int main()
{
    int a = 4;
    int b = 9;
    

    return 0;
}