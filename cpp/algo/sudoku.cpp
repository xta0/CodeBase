#include <iostream>
#include <map>
#include <vector>
using namespace std;

int col[9][10];
int row[9][10];
int block[9][10];
int board[9][9];
struct Value{
    int row;
    int col;
};
vector<Value> blanks;

void init(){
    for(int i=0;i<9;i++){
        for(int j=0;j<10;j++){
            col[i][j] = 0;
            row[i][j] = 0;
            board[i][j] = 0;
        }
    }
}

int block_index(int row, int col){
    return row/3 * 3  + col/3;
}

void set_state(int r, int c, int num){
    col[c][num] = 1;
    row[r][num] = 1;
    block[block_index(r,c)][num] = 1;
}
void clear_state(int r, int c,  int num){
    col[c][num] = 0;
    row[r][num] = 0;
    block[block_index(r,c)][num] = 0;
}
bool can_be_placed(int r, int c, int num){
    if( row[r][num] == 0 && 
        col[c][num] == 0){
        return true;
    }
    return false;
}

bool DFS(int index){
    if(index < 0){
        return true;
    }
    int row = blanks[index].row;
    int col = blanks[index].col;
    for(int num=1;num<=9;num++){
        //枚举num，如果可以被放置
        if(can_be_placed(row, col, num)){
            //填充板子上的值
            board[row][col] = num;
            //设置状态
            set_state(row,col,num);
            //继续递归
            if(DFS(index-1)){
                return true;
            }else{
                //递归失败，回溯清空状态
                 clear_state(row,col,num);
            }
        }
    }
    return false;
}



int main(){

    init();
    for(int i=0;i <9;i++){
        for(int j=0;j<9;j++){
            int x = -1;
            cin >> x;
            if(x == 0){
                blanks.push_back({i,j});
            }
            board[i][j] = x;
        }
    }
    DFS(blanks.size()-1);

    return 0;
}