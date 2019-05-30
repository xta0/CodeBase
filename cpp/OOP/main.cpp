#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Quote
{
public:
	Quote() = default;
	Quote(const string &book, double price) : bookNo(book), price(price){};
	string isbn() const
	{
		return bookNo;
	}
	virtual double net_price(size_t n) const
	{
		return n * price;
	}
	virtual ~Quote() = default; //对析构函数进行动态绑定
	virtual void print()
	{
		cout << bookNo << "," << price << endl;
	}

private:
	string bookNo;

protected:
	double price = 0.0;
};

class Bulk_Quote : public Quote
{
public:
	Bulk_Quote() = default;
	Bulk_Quote(const string &book, double p,
			   size_t qty, double disc) : Quote(book, p), min_qty(qty), discount(disc){
																			//使用统一构造函数初始化基类成员

																		};
	//override虚函数
	double net_price(size_t cnt) const override
	{
		double price = Quote::net_price(cnt);
		return price * discount;
	}
	void print() override
	{
		cout << min_qty << "," << discount << endl;
	}

private:
	size_t min_qty = 0;
	double discount = 0.0;
};

class Base
{
public:
	virtual void print1()
	{
		cout << "base print1" << endl;
	};
	void print2()
	{
		cout << "base print2" << endl;
	}
};
class Derived : public Base
{
public:
	void print1() override
	{
		cout << "child print1" << endl;
	}
	void print2()
	{
		cout << "base print2" << endl;
	}
};

int main()
{

	Derived child;
	Base &parent = child;
	parent.print1(); //会发生动态绑定，调用child的print1
	parent.print2(); //不会发生动态绑定，print2不是虚函数，调用parent的print2

	Base parent2 = child;
	parent2.print1(); //不会发生动态绑定，调用parent的print1，因为parent2不是指针或引用类型

	return 0;
}