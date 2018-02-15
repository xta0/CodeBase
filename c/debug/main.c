#include "dbg.h"
#include <stdlib.h>
#include <stdio.h>
void test_log(){
    debug("Hello Debugger");
    log_err("Wrong number: %d",100);
    log_warn("Empty Size at: %s","Foo");
    log_info("Perter Commited Code at: <%d,%s>",10,"home");
}
int test_check(){
    FILE* input = NULL;
    void* block = NULL;
    block = malloc(100);
    check_mem(block);
   
    input = fopen("./a.txt", "r");
    check(input, "Failed to open file");
    
    if(block) free(block);
    if(input) fclose(input);
    
    return 0;
error:
    if(block) free(block);
    if(input) fclose(input);
    return -1;
}

int test_sentinel(int code){
    
    void *p = malloc(100);
    check_mem(p);
    switch (code) {
        case 1:
            log_info("good");
            break;
        default:
            sentinel("I should't run");
            break;
    }
    if(p) free(p);
    return 0;
error:
    if(p) free(p);
    return -1;
}

int test_check_mem(){
    char* p = NULL;
    check_mem(p);
    
    return 0;
error:
    return -1;
}

int main(){
        test_log();
    test_check();
    test_sentinel(1);
    test_sentinel(100);
    test_check_mem();
    
    
    return 0;
}

