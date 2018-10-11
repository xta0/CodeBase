#include <iostream>
#include <vector>
#include <string>
#include "ring.h"
using namespace std;



int main(){


    ring<string> r(3);
    r.add("one");
    r.add("two");
    r.add("three");
    r.add("four");

    for(int i=0; i<r.size(); i++){
        cout<<r.get(i)<<endl;
    }
    for(ring<string>::iterator itor = r.begin(); itor != r.end(); itor++){
        cout<<*itor<<endl;
    }





    return 0;
}