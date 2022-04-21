int gValue = 0;
extern int exVar;
void set_value(int x) {
  gValue = x;
}

int get_value() {
  return gValue;
}

int demo() {
  exVar = 100;
  return 0;
}