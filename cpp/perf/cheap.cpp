void intByValue(int x);
void intByPointer(const int *x);
void intByReference(const int &x);
void doSomething();  // avoid privileging the "right way" further
 
void callIntByValue() {
  int x = 123;
  intByValue(x);
  doSomething();
}
 
void callIntByPointer() {
  int x = 123;
  intByPointer(&x);
  doSomething();
}
 
void callIntByReference() {
  int x = 123;
  intByReference(x);
  doSomething();
}