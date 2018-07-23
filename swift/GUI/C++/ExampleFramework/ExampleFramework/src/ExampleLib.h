#ifndef ExampleLibImpl_h
#define ExampleLibImpl_h


#include <iostream>
#include <vector>
#include <string>

using namespace std;

namespace example{
    class data_source{
        std::vector<string> data;
    public:
        data_source();
        virtual ~data_source();
        data_source(const data_source& ) = delete;
        data_source& operator=(const data_source& other) = delete;
        void add(string str);
        string get(size_t index);
        size_t size() const;
    };
};




#endif
