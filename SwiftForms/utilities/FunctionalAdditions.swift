//
//  FunctionalAdditions.swift
//  SwiftFormsApplication
//
//  Created by Alan Skipp on 25/07/2015.
//  Copyright (c) 2015 Alan Skipp. All rights reserved.
//


// Apply a function to an Optional value, or return a default value if the Optional is .None
// https://downloads.haskell.org/~ghc/latest/docs/html/libraries/base/Data-Maybe.html#v:maybe

func maybe<A,B>(@autoclosure #defaultValue:() -> B, opt:A?, @noescape f:A -> B) -> B {
    switch opt {
    case .None : return defaultValue()
    case .Some(let x) : return f(x)
    }
}
