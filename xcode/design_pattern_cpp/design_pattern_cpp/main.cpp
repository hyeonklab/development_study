//
//  main.cpp
//  design_pattern_cpp
//
//  Created by admin on 2017. 1. 23..
//  Copyright © 2017년 hyeonk lab. All rights reserved.
//

#include <iostream>

#include "singleton.h"

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World! design pattern\n";
    
    singleton* dd = singleton::instance();
    
//    singleton* _instance = singleton::instance();
    
    return 0;
}
