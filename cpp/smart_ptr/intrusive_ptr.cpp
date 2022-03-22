#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

enum color {
    red,
    green
};
enum class triffic_light {
    red,
    green
};

int main(){

    int x = color::red;
    int y = (int)triffic_light::red;



    return 0;
}