#define f(a,b) a##b
#define g(a)   #a

//gcc -E main.c
int main(){
    f(1,2);
    g(f(1,2));
    return 0;
}