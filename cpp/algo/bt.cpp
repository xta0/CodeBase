#include <iostream>
#include <string>
using namespace std;

class TreeNode{
public:
    TreeNode* left;
    TreeNode* right;
    string val;
    TreeNode(){}
    TreeNode(string s):val(s){}
};

void traverse_recursive(TreeNode* root){
    if(root ){
        traverse_recursive(root->left);
        traverse_recursive(root->right);
        cout<<root->val;
    }
}

int main(){

    // TreeNode* node = new TreeNode("B");
    // node->left = new TreeNode("E");
    // node->right = new TreeNode("D");
    // node->left->left = new TreeNode("X");
    // node->left->right = new TreeNode("K");
    // node->left->left->left = new TreeNode("L");
    // node->left->left->right = new TreeNode("M");
    // node->left->right->left = new TreeNode("C");
    // node->left->right->right = new TreeNode("P");
    // node->right->left = new TreeNode("H");
    // node->right->right = new TreeNode("A");
    // node->right->left->left = new TreeNode("Q");
    
    TreeNode* node = new TreeNode("A");
    node->left = new TreeNode("B");
    node->left->left = new TreeNode("C");
    traverse_recursive(node);


    return 0;
}