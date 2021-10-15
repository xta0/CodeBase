#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;
#include "./shim.h"

int main(){
    using namespace facebook::pytorch;
    std::unique_ptr<ExampleModulShim> shim = PyTorchExampleShim::getImpl()->loadModule("");
    // shim->runModel();

    return 0;
}