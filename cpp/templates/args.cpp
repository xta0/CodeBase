#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

template<unsigned N, unsigned M>
int compare(const char(&p1)[N], const char(&sp2)[M]){
	return strcmp(p1,p2);
}
int main(){
    compare("h1","h11");
    return 0;
}