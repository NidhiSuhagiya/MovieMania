//
//  Validation.swift
//  MindFit
//
//  Created by ob_apple_2 on 8/25/17.
//  Copyright © 2017 ob_apple_2. All rights reserved.
//

import Foundation

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func checkLength(testStr:String) -> Bool {
    if testStr.trimmingCharacters(in: .whitespaces).isEmpty || testStr.characters.count<0{
        return false
    } else {
        return true
    }
//    if testStr.characters.count>0 {
//        return true
//    }else{
//        return false
//    }
}

func validateTextView(testStr:String) -> Bool {
    let tvRegEx = "^.{150,}$"
    let tvTest = NSPredicate(format:"SELF MATCHES %@", tvRegEx)
    
    return tvTest.evaluate(with: testStr)
}

func validatePassword(testStr:String) -> Bool {
    
    let passwordRegEx = "^.{6,}$"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    
    return passwordTest.evaluate(with: testStr)
}

func validatePhonenumber(value: String) -> Bool {
//    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let PHONE_REGEX = "^.{10,}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

func validateContactUsPhonenumber(value: String) -> Bool {
    //    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let PHONE_REGEX = "^.{8,}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

func validateUserName(testStr:String) -> Bool {
    
    let regEx = "^.{3,18}$"
    let test = NSPredicate(format: "SELF MATCHES %@", regEx)
    return test.evaluate(with: testStr)
}

func validateYear(testStr:String) -> Bool {
    
    let regEx = "^[0-9]{4}$"
    let test = NSPredicate(format: "SELF MATCHES %@", regEx)
    return test.evaluate(with: testStr)
}
