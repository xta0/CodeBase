#include <iostream>

template<typename T>
T funcT(T x){
    return x;
};

inline int func() {
    std::cout<<"func is called!"<<std::endl;
    return 0;
}
