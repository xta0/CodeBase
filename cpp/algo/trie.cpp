#include <iostream>
#include <vector>
#include <string>
#include <array>
using namespace std;

struct TrieNode{
    bool isEnd = false;
    array<TrieNode*,26> children = {nullptr};
    ~TrieNode(){
        for(auto& x:children){
            delete x;
            x = nullptr;
        }
    }
};

class Trie{
    TrieNode* root;
public:
    Trie(){
        root = new TrieNode();
    }
    virtual ~Trie(){
        delete root;
        root = nullptr;
    }
    void insert(string word){
        TrieNode* node = root;
        for(int i=0;i<word.size();i++){
            char c = word[i];
            int index = c-'a';
            TrieNode* child = node->children[index];
            if(!child){
                node->children[index] = new TrieNode();
                node = node->children[index];
            }else{
                node = child;
            }
        }
        node->isEnd = true;
    }
    bool hasPrefix(string prefix){
        TrieNode* node = root;
        for(int i=0;i<prefix.size();i++){
            char c = prefix[i];
            int index = c-'a';
            TrieNode* child = node->children[index];
            if(!child){
                return false;
            }
            node = child;
        }
            
        return true;
        
    }

};


int main(){
    Trie* trie = new Trie();
    trie->insert("spider");
    trie->insert("batman");
    trie->insert("Superman");
    trie->insert("ironman");

    cout<<trie->hasPrefix("bat")<<endl;
    cout<<trie->hasPrefix("Sup")<<endl;
    cout<<trie->hasPrefix("cool")<<endl;

    return 0;
}