#include <iostream>
#include <thread>
#include <mutex>
#include <shared_mutex>
#include <list>
#include <algorithm>
#include <map>

std::list<int> some_list;
std::mutex some_mutex;


void write(int new_values){
    std::lock_guard<std::mutex> guard(some_mutex);
    some_list.push_back(new_values);
    std::unique_lock<std::mutex> ll(some_mutex);
    
}
bool find(int value_to_find){
    std::lock_guard<std::mutex> guard(some_mutex);
    return (std::find(some_list.begin(), some_list.end(), value_to_find) != some_list.end());
}

class some_class{};
void swap(some_class& v1, some_class& v2);
class X{
private: 
    some_class data;
    std::mutex m;
public:
    friend void swap(X& lhs, X& rhs){
        if(&lhs == &rhs){
            return;
        }
        std::lock(lhs.m, rhs.m);
        std::lock_guard<std::mutex> lock_a(lhs.m, std::adopt_lock);
        std::lock_guard<std::mutex> lock_b(rhs.m, std::adopt_lock);
        swap(lhs.data, rhs.data);
    }
};

class dns_entry{};

class dns_cache{
    std::map<std::string, dns_entry> entries;
    mutable std::shared_mutex entry_mutex;
public:
    dns_entry find_entry(std::string const& domain ) const{
        std::shared_lock<std::shared_mutex> lk(entry_mutex);
        auto itor = entries.find(domain);
        if(itor != entries.end()){
            return itor->second;
        }else{
            return dns_entry();
        }
    }
    void update_or_add_entry(std::string const& domain, dns_entry const& dns_details){
        std::lock_guard<std::shared_mutex> lg(entry_mutex);
        entries[domain] = dns_details;
    }
};



int main(){





    return 0;
}