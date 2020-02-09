//a.c
int myintvar = 5;
 
int func0 () {
  return ++myintvar;
}
 
int __attribute__ ((visibility ("default"))) func1 (int i) {
  return func0() * i;
}
