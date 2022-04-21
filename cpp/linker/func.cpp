int gValue = 100;
static int ival = 10;
static int boo(int x) {
  return x+ival;
}
int func(int x) {
  return boo(x);
}
