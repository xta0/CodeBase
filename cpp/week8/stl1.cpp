#include <vector>
#include <iostream>

int main(int argc, char const *argv[])
{

	std::vector<int> v;
	v.push_back(1);
	v.push_back(2);
	v.push_back(3);

	std::vector<int>::const_iterator i;
	for (i = v.begin(); i != v.end(); ++i)
	{
		std::cout << *i << std::endl;
	}
	v.hash();

	return 0;
}