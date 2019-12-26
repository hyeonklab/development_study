//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var value = [3, 5, 2, 1, 3, 7, 4, 9]

func order (s1: Int, s2: Int)->Bool
{
    if(s1 > s2)
    {
        return true
    }
    else
    {
        return false
    }
}

//let asc =
//{
//    s1, s2 in
//    return s1 < s2
//}

//value.sort(by: < )

value.sort { (s1, s2) in return s1 > s2 }

func condition(stmt: @autoclosure ()->Bool )
{
    if stmt() == true
    {
        print("true")
    }
    else
    {
        print("false")
    }
}

condition(stmt: (4 > 2) )
