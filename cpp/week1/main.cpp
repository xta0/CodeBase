#include <iostream>

using namespace std;

int main()
{
    int a,b = 0;
    
__A:
    cout << "enter  number (1-10):"<<"\n";
    cin >> a;
    if (a < 0 || a > 10)
    {
        cout << "number out of range"<<"\n";
        goto __A;
    }
__B:     
    cout << "enter number (1-10):"<<"\n";
    cin >> b;

    if (b < 0 || b  > 10)
    {
        cout << "number out of range"<<"\n";
        goto __B;
    }

    cout << "Output: "<<a+b;
    
    return 0;
}