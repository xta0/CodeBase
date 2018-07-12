#include <iostream>
#include <vector>
#include <string>
using namespace std;

template <class T>
struct ListNode {
    T val;
    ListNode *next;
    ListNode(T x) : val(x), next(NULL) {}
    ~ListNode(){
        cout<<"Deleted: "<<val<<endl;
    }
    bool operator==(const ListNode<T>* node){
        return val == node->val;
    }
};
template<typename T>
class LinkedList {
    ListNode<T>* head = nullptr;
    ListNode<T>* tail = nullptr;
    int count = 0;
public:
    explicit LinkedList(T value){
        head = new ListNode<T>(value);
        tail = head;
        count ++;
    }
    ~LinkedList(){
//        while(head){
//            ListNode<T>* tmp = head;
//            head = head->next;
//            delete tmp;
//            tmp = nullptr;
//        }
    }
    LinkedList(const LinkedList& ) = delete;
    LinkedList& operator=(const LinkedList& ) = delete;
    
    //search by value
    ListNode<T>* searchByValue(T val){
        ListNode<T>* runner = head;
        while(runner){
            if(runner->val == val){
                return runner;
            }
            runner = runner->next;
        }
        return nullptr;
    }
    //search by index
    ListNode<T>* searchByIndex(int index){
        if(index < 0){
            return nullptr;
        }
        if(count <= index){
            return nullptr;
        }
        int i = 0;
        ListNode<T>* runner = head;
        while(runner){
            if(index == i){
                return runner;
            }
            runner = runner->next;
            i++;
        }
        return nullptr;
    }
    //add node to the tail
    void addNode(T val){
        ListNode<T> *node = new ListNode<T>(val);
        tail->next = node;
        tail = tail->next;
        count++;
    }
    //insert
    bool insert(T val, int index){
        
        if(index == 0){
            ListNode<T>* node = new ListNode<T>(val);
            node->next = head;
            head = node;
            count++;
            return true;
        }
    
        ListNode<T>* prev = searchByIndex(index-1);
        if(!prev){
            return false;
        }
        ListNode<T>* node = new ListNode<T>(val);
        ListNode<T>* succ = prev->next;
        if(!succ){
            //node is the tail
            prev->next = node;
            //update the tail
            tail = node;
        }else{
            prev->next = node;
            node->next = succ;
        }
        count ++;
        return true;
    }
    //delete
    bool deleteByValue(T value){
        
        //delete head node
        if(head->val == value){
            ListNode<T>* tmp = head;
            head = head->next;
            delete tmp;
            tmp = nullptr;
            count--;
            return true;
        }else{
            
            ListNode<T>* prev = head;
            while( prev->next ){
                if(prev->next->val == value){
                    break;
                }
                prev = prev->next;
            }
            if(prev == tail){
                return false;
            }
            
            ListNode<T>* node = prev->next;
            ListNode<T>* succ = node->next;
            if(!succ){
                tail = prev;
                tail->next = nullptr;
            }else{
                prev->next = succ;
            }
            delete node;
            node = nullptr;
            count--;
            return true;
        }
  
    }
    bool deleteByIndex(int index){
        if(index == 0){
            ListNode<T>* tmp = head;
            head = head->next;
            delete tmp;
            tmp = nullptr;
            count--;
            return true;
        }else{
            ListNode<T>* prev = searchByIndex(index-1);
            if(!prev){
                return false;
            }
            if(prev == tail){
                return false;
            }
            ListNode<T>* node = prev->next;
            ListNode<T>* succ = node->next;
            if(!succ){
                tail = prev;
                tail->next = nullptr;
            }else{
                prev->next = succ;
            }
            delete node;
            node = nullptr;
            count--;
            return true;
        }

    }
    bool length() const{
        return count;
    }
    //helper
    void log(){
        cout<<"count: "<<count<<endl;
        ListNode<T>* runner = head;
        int index = 0;
        while(runner){
            cout<<"(#"<<index<<" ,"<<runner->val<<")";
            if(runner->next){
                cout<<"->";
            }else{
                cout<<endl;
            }
            runner = runner->next;
            index ++;
        }
    }
};

void test_SearchByIndex(LinkedList<int>& list, int index){
    auto node = list.searchByIndex(index);
    if(!node){
        cout<<"NULL"<<endl;
    }else{
        cout<<node->val<<endl;
    }
}

void test_SearchByValue(LinkedList<int>& list, int value){
    auto node = list.searchByValue(value);
    if(!node){
        cout<<"NULL"<<endl;
    }else{
        cout<<node->val<<endl;
    }
}
void test_insert(LinkedList<int>& list, int index, int value){
    if(list.insert(value, index)){
        list.log();
    }else{
        cout<<"😭Insert Failed!"<<endl;
    }
}
void test_deleteByValue(LinkedList<int>& list, int number){
    if(list.deleteByValue(number)){
        list.log();
    }else{
        cout<<"😭Delete Failed!"<<endl;
    }
}

void test_deleteByIndex(LinkedList<int>& list, int index){
    if(list.deleteByIndex(index)){
        list.log();
    }else{
        cout<<"😭Delete Failed!"<<endl;
    }
}

int main(){
    
    LinkedList<int> list(10);
    list.addNode(11);
    list.addNode(12);
    list.addNode(13);
    list.log();
//    test_SearchByIndex(list,2);
//    test_SearchByValue(list,13);
//    test_insert(list, 0, 99);
//    test_deleteByValue(list, 13);
    // test_deleteByIndex(list, 3);

    return 0;
}
