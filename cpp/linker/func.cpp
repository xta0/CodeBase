int gValue = 0;
extern int exVar;
extern int func1();
void set_value(int x) {
  gValue = x;
}

int get_value() {
  return gValue;
}

int demo() {
  return func1();
}