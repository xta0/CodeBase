#include <iostream>
using   namespace std;

class Animal{
    int legs;
    virtual void speak(){ 
        cout<<__func__<<endl;
    };
    virtual ~Animal(){
        
    }
};

class Cat: public Animal{
    int tails;
    void speak() override {
        cout<<__func__<<endl;
    }
};