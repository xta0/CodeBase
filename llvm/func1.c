int func1(int a, int b){
     int c = 10; 
     return a+b+c;
}
//clang -emit-llvm -S func1.c -o func1.ll