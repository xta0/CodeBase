
#include <iostream>
#include <queue>
#include <cmath>
#include <map>


using namespace std;

void drawLine(double x, double y, double x1, double y1){
    //dummy functions
}
void drawHTreeDFS(double x, double y, double length, double depth){
    if(depth == 0){
        return;
    }
    cout<<x<<","<<y<<","<<length<<","<<depth<<endl;
    
    //draw a "H" Tree
    drawLine(x-0.5*length,y, x+0.5*length,y);
    drawLine(x-0.5*length,y-0.5*length,x-0.5*length,y+0.5*length);
    drawLine(x+0.5*length,y-0.5*length,x+0.5*length,y+0.5*length);
    
    
    //update length
//    length /= sqrt(2);
    double len = length /= 2;
    
    //recursively draw four H Trees
    drawHTreeDFS(x-0.5*length, y-0.5*length, len, depth-1);
    drawHTreeDFS(x+0.5*length, y-0.5*length, len, depth-1);
    drawHTreeDFS(x-0.5*length, y+0.5*length, len, depth-1);
    drawHTreeDFS(x+0.5*length, y-0.5*length, len, depth-1);
    
    
    
}
void drawHTreeBFS(double x, double y, double length, double depth){
    queue<pair<double,double>> q;
    q.push({x,y});
    int level = 0;
    while(!q.empty()){
        level++;
        if(level > depth){
            break;
        }
        size_t sz = q.size();
        for(int i=0;i<sz;i++){
            auto pt = q.front();
            q.pop();
            double x = pt.first;
            double y = pt.second;
            cout<<x<<","<<y<<","<<length<<","<<level<<endl;
            //draw a "H" Tree
            drawLine(x-0.5*length,y, x+0.5*length,y);
            drawLine(x-0.5*length,y-0.5*length,x-0.5*length,y+0.5*length);
            drawLine(x+0.5*length,y-0.5*length,x+0.5*length,y+0.5*length);
            
            //bfs
            q.push({x-0.5*length/2, y-0.5*length/2});
            q.push({x+0.5*length/2, y-0.5*length/2});
            q.push({x-0.5*length/2, y+0.5*length/2});
            q.push({x+0.5*length/2, y-0.5*length/2});
            
        }
        //update length
        length /= 2;
        cout<<"--"<<endl;
        
    }
}
/*
 100,100,16,3
 --
 96,96,8,2
 104,96,8,2
 96,104,8,2
 104,96,8,2
 --
 94,94,4,1
 98,94,4,1
 94,98,4,1
 98,94,4,1
 
 102,94,4,1
 106,94,4,1
 102,98,4,1
 106,94,4,1
 
 94,102,4,1
 98,102,4,1
 94,106,4,1
 98,102,4,1
 
 102,94,4,1
 106,94,4,1
 102,98,4,1
 106,94,4,1
 --
 */
int main()
{
    std::cout << "Practice makes Perfect!" << std::endl;
//    drawHTreeDFS(100,100,16,3);
    drawHTreeBFS(100,100,16,3);
    return 0;
}
