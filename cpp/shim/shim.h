// (c) Facebook, Inc. and its affiliates. Confidential and proprietary.
#pragma once

#include <memory>
#include <stdexcept>
#include <iostream>

namespace facebook {
namespace pytorch {

    class ExampleModulShim {
    public:
        virtual ~ExampleModulShim() = default;
        virtual void runModel(void) = 0;
    };

    class PyTorchExampleShim {
    public:
        virtual ~PyTorchExampleShim() = default;
        static PyTorchExampleShim* getImpl() {
            std::cout<<"getImpl()"<<std::endl;
            if (!impl_) {
                throw std::runtime_error("PyTorchExampleShim not initialized.");
            }
            return impl_;
        }
        virtual std::unique_ptr<ExampleModulShim> loadModule(std::string modelPath) = 0;
     protected:
        static PyTorchExampleShim* impl_;
    };
}
}