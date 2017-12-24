#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>

using namespace std;
class CIntArray
{
  private:
	int *ptr;
	int size;
	int cursor;

  public:
	CIntArray() : ptr(NULL)
	{
		size = 0;
		cursor = 0;
	};

	CIntArray(int sz) : size(sz)
	{
		if (sz == 0)
		{
			cursor = 0;
			ptr = NULL;
		}
		else
		{
			cursor = 0;
			ptr = new int(sz);
			memset(ptr, 0, sz * sizeof(int));
		}
	}

	CIntArray(CIntArray &list)
	{
		if (!list.ptr)
		{
			ptr = NULL;
			size = 0;
			return;
		}
		else
		{
			if (ptr)
			{
				delete[] ptr;
				ptr = NULL;
			}

			size = list.size;
			ptr = new int(list.size);
			memcpy(ptr, list.ptr, list.size * sizeof(int));
		}
	}

	~CIntArray()
	{

		if (ptr)
		{
			delete[] ptr;
			ptr = NULL;
		}
	}

	//push会改变size
	void push(int x)
	{
		if (ptr == NULL)
		{
			ptr = new int(1);
			ptr[0] = x;
		}
		else
		{
			int *new_ptr = new int[size + 1];
			memcpy(new_ptr, ptr, size * sizeof(int));
			delete[] ptr;
			ptr = new_ptr;
			ptr[cursor] = x;
			cursor++;
		}
	}

	void pop()
	{
		cursor--;
	}

	int length() { return this->size; }

	CIntArray &operator=(const CIntArray &list)
	{
		if (ptr == list.ptr)
		{
			return *this;
		}

		if (list.ptr == NULL)
		{
			if (ptr)
			{
				delete[] ptr;
				ptr = NULL;
				size = 0;
			}
		}

		if (ptr)
		{
			delete[] ptr;
			ptr = NULL;
		}

		if (size < list.size)
		{
			if (ptr)
			{
				delete[] ptr;
				ptr = new int[list.size];
			}
		}
		size = list.size;
		memcpy(ptr, list.ptr, list.size * sizeof(int));

		return *this;
	}

	int &operator[](int x)
	{
		return ptr[x];
	}
};

void logArray(CIntArray &b)
{
	cout << "------" << endl;

	for (int i = 0; i < b.length(); ++i)
	{
		printf("b[%d]:%d\n", i, b[i]);
	}
}

int main(int argc, char *argv[])
{

	CIntArray a;
	CIntArray b(3);
	logArray(b);
	b.push(1);
	b.push(2);
	b.push(3);
	b.push(4);
	logArray(b);

	// a = b;
	// printf("a[0]:%d\n",a[0]);
	// printf("a[1]:%d\n",a[1]);

	return 0;
}
