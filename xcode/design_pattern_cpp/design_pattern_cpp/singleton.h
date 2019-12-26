//
//  singleton.h
//  design_pattern_cpp
//
//  Created by admin on 2017. 1. 23..
//  Copyright © 2017년 hyeonk lab. All rights reserved.
//

#ifndef singleton_h
#define singleton_h

#include <iostream>

class singleton
{
private:
    static singleton* instance_;
    
protected:
    singleton();
    ~singleton()
    {
        std::cout << "destructor";
    };
    
public:
    static singleton* instance()
    {
        if ( instance_ == 0 )
        {
            instance_ = new singleton;
        }
        return instance_;
    };
    
};

singleton* singleton::instance_ = nullptr;

#endif /* singleton_h */
