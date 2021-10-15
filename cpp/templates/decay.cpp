#include <iostream>
#include <type_traits>




using namespace std;

template <typename T1, typename T2>
auto max(T1 a, T2 b) -> typename std::decay<decltype(true ? a : b)>::type //c++ 14
{
    return a > b ? a : b;
}

template <typename It>
auto fn (It beg, It end) -> typename std::remove_reference<decltype(*beg)>::type {
	return *beg;
}

//c++14
template <typename It>
auto fn (It beg, It end) -> typename std::decay<decltype(*beg)>::type {
	return *beg;
}

int main()
{
    int x = 10;
    const int &a = x;
    const int &b = x + 1;
    std::cout << ::max(a, b) << std::endl;

    return 0;
}