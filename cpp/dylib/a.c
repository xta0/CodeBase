//a.c
int myintvar = 5;
 
int func0 () {
  return ++myintvar;
}
 
int func1 (int i) {
  return func0() * i;
}
