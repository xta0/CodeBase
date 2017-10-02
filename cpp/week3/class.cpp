#include <iostream>


class Man
{
private: 
	int age;
	char* name;
	static int group;
public: 
	Man(int age, char *name);
	Man(){}
	Man(const Man& man){};
	Man(char* name){this->age = 10; this->name = name;};
	~Man()
	{
		//printf("%p ==> dealloc\n", this);
	}

	char* getName(){return this -> name;}
	int getAge(){return this->age;}
	void func() { std::cout<<"a\n";}
	void boo();
	inline void foo(){}
	static void loo(){printf("loo is called!\n");}
};

void Man::boo(){}
Man::Man(int age, char* name)
{
	this -> age = age;
	this -> name = name;
}



class Driver;
class Car
{
private:
	int price;

public:
	Car(int p):price(p){}

//友元
friend int mostExpensiveCar(Car* pCar);
friend class Driver;

};

class Driver
{
public:
	void getCarPrice(Car* pCar){printf("%s_Car.price:%d\n",__FUNCTION__,pCar->price);};
};

int mostExpensiveCar(Car* pCar)
{
	printf("%s_Car.price:%d\n",__FUNCTION__,pCar->price);


};

class Hello
{
private:
	int value;
public:
		void hello(){printf("hello!\n");};
		void getValue() const;
		void foo(){}
};

void Hello::getValue() const
{
	value = 0;//wrong;
	foo(); //error
} 



int main(int argc, char** argv)
{
	Hello* p = NULL;
	p -> hello();

	//
	class A
	{	


	};

	A* a = new A();



	Man m,n;
	m.func();
	m.loo();

	char* name = "jayson";
	printf("name1: %p\n", name);

	name = "abc";
	printf("name2: %p\n", name );
	int age = 29;

	Man* man = new Man(age,name);
	man -> loo();
	delete(man);

//赋值构造函数
	Man c1(100,"jayson");
	Man c2 = "kate";
	c1 = "jason";

//访问静态成员
	Man::loo();

	//友元
	Car car(100);
	mostExpensiveCar(&car);
	Driver driver;
	driver.getCarPrice(&car);






	return 0;
}
