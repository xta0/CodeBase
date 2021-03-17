#include "./shim.h"
#include <iostream>
#include <string>

namespace facebook {
namespace pytorch {

class ExampleModulShimImpl : public ExampleModulShim {
public:
  ExampleModulShimImpl(std::string modelPath) {
      std::cout<<"ExampleModulShimImpl(string modelPath)"<<std::endl;
  }
  void runModel(void) override {
      std::cout<<"runModel"<<std::endl;
  }
};

class PyTorchExampleShimImpl : public PyTorchExampleShim {
public:
    std::unique_ptr<ExampleModulShim> loadModule(std::string modelPath) override {
        std::cout<<"loadModule"<<std::endl;
        return nullptr;
    }
private:
    PyTorchExampleShimImpl() {
        std::cout<<"PyTorchExampleShimImpl()"<<std::endl;
        impl_ = this;
    }
    static PyTorchExampleShimImpl theImpl_;
};
PyTorchExampleShimImpl PyTorchExampleShimImpl::theImpl_;

}
}