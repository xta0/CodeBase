
#include <iostream>

class CStudent
{
public:
	CStudent(int _age, char* _name):age(_age),name(_name)
	{

	};
	int age;
	char* name;

};

std::ostream& operator<<(std::ostream& o, const CStudent &s)
{
		o<<s.name;
		return o;
}


int main(int argc, char const *argv[])
{
	/* code */
	CStudent s(10,"jayson");
	// s.age = 10;
	std::cout<<s;
	return 0;
}