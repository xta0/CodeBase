#include <iostream>

template <class T1, class T2>
class Pair
{
  public:
	T1 key;
	T2 value;
	Pair(T1 _key, T2 _value) : key(_key), value(_value){

										  };
	bool operator<(const Pair<T1, T2> &p) const
	{
		return this->value < p.value;
	}
	template <class T3>
	void func(T3 t) { std::cout << t; }
};

int main(int argc, char const *argv[])
{
	Pair<std::string, int> p1("age", 123);
	Pair<std::string, int> p2("name", 22);
	bool ret = p1 < p2;
	printf("ret:%d\n", ret);
	p1.func("argc");

	return 0;
}