/* use.c */
#include "B.h"
void use() {
#ifdef ENABLE_A
  a();
#endif
}
