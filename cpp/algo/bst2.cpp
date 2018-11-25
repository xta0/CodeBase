#include <iostream>

using namespace std;

struct Node
{
    int key;
    Node *left;
    Node *right;
    Node *parent;
};

// Helper function that allocates a new Node
Node* newNode( int key )
{
    Node* n = new Node;
    n->key = key;
    n->left = nullptr;
    n->right = nullptr;
    n->parent = nullptr;
    
    return n;
}

//  Given a binary search tree and a number, inserts a new Node with
//  the given number in the correct place in the tree. Returns the new
//  root pointer which the caller should then use
Node *insert( Node *root, int key )
{
    // 1) If the tree is empty, return a new single Node
    if( root == nullptr )
        return newNode( key );
    
    Node *temp;
    
    // 2) Otherwise, recur down the tree
    if( key < root->key )
    {
        temp = insert( root->left, key );
        root->left = temp;
        temp->parent = root;
    } else
    {
        temp = insert( root->right, key );
        root->right = temp;
        temp->parent = root;
    }
    
    // Return the (unchanged) Node pointer
    return root;
}

///////////////////////////////////////////////////////////////////////////////
//inorder traversal solution
// void inorder(Node* rootNode, Node*& prev, Node*& end, int num){
//     if(!rootNode){
//         return;
//     }
//     inorder(rootNode->left, prev, end,num);
//     end = rootNode;
//     if(end->key >= num){
//         return ;
//     }
//     //track the prev node
//     prev = rootNode;
//     inorder(rootNode->right, prev, end,num);
// }

// int findLargestSmallerKey(Node *rootNode, int num)
// {
//     Node* prev = nullptr;
//     Node* end = nullptr;
//     inorder(rootNode, prev, end, num);
//     if(!prev){
//         return -1;
//     }else{
//         if(num > end->key){
//             return end->key;
//         }else{
//             return prev->key;
//         }
//     }
// }

///////////////////////////////////////////////////////////////////////////////
//Binary Search Solution
int findLargestSmallerKey(Node *rootNode, int num){
    int result = -1;
    while( rootNode ){
        if(num > rootNode->key){
            result = rootNode->key;
            rootNode = rootNode->right;
        }else{
            rootNode = rootNode->left;
        }
    }
    
    return result;
}

///////////////////////////////////////////////////////////////////////////////
//Binary Search Solution
int findSmallestLargerKey(Node* rootNode, int num){
    int result = -1;
    while( rootNode ){
        if( num < rootNode-> key ){
            result = rootNode->key;
            rootNode = rootNode->left;
        }else{
            rootNode = rootNode->right;
        }
    }
    return result;
}


int main() {
    
    //3,5,9,11,12,14,20,25
    Node* root = insert(NULL, 20);
    insert(root, 9);
    insert(root, 25);
    insert(root, 5);
    insert(root, 12);
    insert(root, 11);
    insert(root, 14);

    // cout<<findLargestSmallerKey(root,17)<<endl;
    // cout<<findLargestSmallerKey(root,26)<<endl;
    // cout<<findLargestSmallerKey(root,5)<<endl;
    // cout<<findLargestSmallerKey(root,25)<<endl;
    // cout<<findLargestSmallerKey(root,3)<<endl;
    // cout<<findLargestSmallerKey(root,20)<<endl;
    // cout<<"--"<<endl;
    cout<<findSmallestLargerKey(root,17)<<endl;
    cout<<findSmallestLargerKey(root,26)<<endl;
    cout<<findSmallestLargerKey(root,5)<<endl;
    cout<<findSmallestLargerKey(root,25)<<endl;
    cout<<findSmallestLargerKey(root,3)<<endl;
    cout<<findSmallestLargerKey(root,20)<<endl;
 

    
    
    return 0;
}
