//code coverage demo
//https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#the-code-coverage-workflow

// Clang ships two other code coverage implementations:
// 1.SanitizerCoverage - A low-overhead tool meant for use alongside the various sanitizers. It can provide up to edge-level coverage.
// 2. gcov - A GCC-compatible coverage implementation which operates on DebugInfo. This is enabled by -ftest-coverage or --coverage.

// step1: clang++ -fprofile-instr-generate -fcoverage-mapping cc.cpp -o cc 
// step2: LLVM_PROFILE_FILE="cc.profraw" ./cc
// step3: xcrun llvm-profdata merge -sparse cc.profraw -o cc.profdata 
// step4: xcrun llvm-cov show ./cc -instra-profile=cc.profdata
// step5: xcrun llvm-cov report ./cc -instr-profile=cc.profdata
#define BAR(x) ((x) || (x))

template <typename T> 
void foo(T x) {
  for (unsigned I = 0; I < 10; ++I) { 
      BAR(I); 
   }
}

int main() {
  foo<int>(0);
  foo<float>(0);
  return 0;
}