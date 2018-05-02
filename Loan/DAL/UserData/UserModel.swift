//
//  UserModel.swift
//  Health
//
//  Created by Yalin on 15/9/11.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

struct UserModel {
    var userId: Int
    var age: UInt8 {
        
        return UInt8(Date(timescampStr: birthday)!.age())
    }
    var birthday: String
    var gender: Bool  // true为男  false为女
    var height: UInt8
    var name: String
    var headURL: String?
    
    init(info: [String : AnyObject]) {
        
        self.userId = 0
        
        if let userId = info["userId"] as? NSString {
            self.userId = userId.integerValue
        }
        
        if let userId = info["userId"] as? NSNumber {
            self.userId = userId.intValue
        }
        
        if let userId = info["subUserId"] as? NSString {
            self.userId = userId.integerValue
        }
        
        if let userId = info["subUserId"] as? NSNumber {
            self.userId = userId.intValue
        }
        
        
        
        birthday = info["birthday"] as! String
        
        if let gender = info["gender"] as? NSString {
            self.gender = gender.integerValue == 1 ? true : false
        }
        else if let gender = info["gender"] as? NSNumber {
            self.gender = gender.int32Value == 1 ? true : false
        }
        else {
            self.gender = true
        }
        
//        gender = (info["gender"] as! NSString).intValue == 1 ? true : false
//        gender = (info["gender"] as! NSNumber).boolValue
        
        if let height = info["height"] as? NSString {
            self.height = UInt8(height.integerValue)
        }
        else if let height = info["height"] as? NSNumber {
            self.height = height.uint8Value
        }
        else {
            self.height = 160
        }
        
//        height = UInt8((info["height"] as! NSString).integerValue)
        name = info["name"] as! String
        
        if let url = info["headURL"] as? String {
            headURL = url
        }
    }
    
    init(userId: Int, birthday: String, gender: Bool, height: UInt8, name: String, headURL: String?) {
        self.userId = userId
        self.birthday = birthday
        self.gender = gender
        self.height = height
        self.name = name
        self.headURL = headURL
    }
}
