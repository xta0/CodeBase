#include <iostream>

class String
{
  private:
	char *str;

  public:
	String() : str(NULL){};
	String(char *s)
	{
		if (s)
		{
			str = new char[strlen(s) + 1];
			strcpy(str, s);
		}
		else
		{
			str = NULL;
		}
	}

	const char *c_str() { return str; }

	char *operator=(const char *s)
	{
		if (str)
		{
			delete[] str;
			/* code */
		}

		if (s)
		{
			str = new char[strlen(s) + 1];
			strcpy(str, s);
		}
		else
		{
			str = NULL;
		}

		return str;
	}
	~String()
	{
		if (str)
			delete[] str;
	};
};
int main(int argc, char const *argv[])
{

	String s("jayson");
	std::cout << s.c_str() << std::endl;

	s = "kate";
	std::cout << s.c_str() << std::endl;

	String a = "base"; //这个不是操作符重载，是调用赋值构造函数
	std::cout << a.c_str() << std::endl;

	return 0;
}
