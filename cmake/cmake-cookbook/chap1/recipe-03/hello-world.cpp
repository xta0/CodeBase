#include "Message.h"
#include "Torch.h"
#include <cstdlib>
#include <iostream>

int main() {
  Message say_hello("Hello, CMake World!");
  std::cout << say_hello << std::endl;
  Message say_goodbye("Goodbye, CMake World");
  std::cout << say_goodbye << std::endl;

  Torch th1("th1");
  th1.foo();
  th1.bar();

  // Torch th2("th2", "th3");
  // th2.foo();
  // th2.bar();

  return EXIT_SUCCESS;
}