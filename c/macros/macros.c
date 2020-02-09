//gcc -E macros.c

// #define COMB(a,b) a ## b
// // #define IIF(cond) IIF_ ## cond
// #define IIF(cond) COMB(IIF_, cond)
// #define IIF_0(t,f) f
// #define IIF_1(t,f) t

// IIF(1)(true,false) //#IIF_1(true,false) -> true

// #define A() 1
// IIF(A())(true,false)
//in this case,  it expends to IIF_A()(true, false), not IIF_1(true, false)
//

#define STRINGIFY(a) #a
#define CONCAT_(a,b) a ## b
#define CONCAT(a,b) CONCAT_(a,b)
#define x() 1
//CONCAT_(a,x()) //ax(), 此时x()不会自动展开
//CONCAT(a,x()) //CONCAT_(a,x()) -> CONCAT_(a,1) -> a1

// #define IIF(a) CONCAT_(IIF_,a)
#define IIF(a) IIF_ ## a
#define IIF_0(t, f) f
#define IIF_1(t, f) t
#define IF_DEF(x) { printf(STRINGIFY(x)); if(IIF(x)(YES,NO)) { NSLog(@STRINGIFY(x)); } } 
// #define IF_DEF_NO(x)
#define C10_MOBILE 
IF_DEF(C10_MOBILE)




// #define CONCAT2(x,y) x##y
// #define CONCAT(x,y) CONCAT2(x,y)
// #define REQ_ENTRY_YES(p1) NSLog(@STRINGIFY(x));
// #define REQ_ENTRY_NO(p1) 
// #define IS_PAIR_HELPER(a, b, c, ...) c
// #define IS_PAIR(...) IS_PAIR_HELPER(__VA_ARGS__, YES, NO)
// #define REQ_ENTRY(pair) CONCAT(REQ_ENTRY_, IS_PAIR(pair))(pair)


