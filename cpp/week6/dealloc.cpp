#include <iostream>

class Son
{
  public:
	Son(){};
	virtual ~Son() { std::cout << "Son dealloc!" << std::endl; };
};

class Grandson : public Son
{
  public:
	Grandson(){};
	~Grandson() { std::cout << "Grandson dealloc" << std::endl; };
};

class A
{
  public:
	virtual void f() = 0;
	void g() { this->f(); }
};

class B : public A
{
  public:
	void f() { std::cout << "B:f()" << std::endl; }
};

int main(int argc, char const *argv[])
{
	Son *pson = (Son *)new Grandson();
	delete pson;

	B b;
	b.g();

	return 0;
}