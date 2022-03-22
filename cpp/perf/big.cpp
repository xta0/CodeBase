struct BigStruct {
  int x[128];
};
void structByValue(BigStruct s);
void structByPointer(const BigStruct *s);
void doSomething();
 
void callStructByPointer(int unused, BigStruct s) {
  structByPointer(&s);
  doSomething();
}
 
void callStructByValue(BigStruct s) {
  structByValue(s);
  doSomething();
}