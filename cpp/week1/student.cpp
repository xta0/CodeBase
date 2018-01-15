#include <iostream>
#include <string>

using namespace std;

class Student{

private:
    string name;
    unsigned int age;
    unsigned int id;
    unsigned int first;
    unsigned int second;
    unsigned int third;
    unsigned int forth;        
}

int main(){
    Student st;
    cout<<"Please Input Student's name,age,id, grade. seperated by comma"<<"\n";
    return 0;
}