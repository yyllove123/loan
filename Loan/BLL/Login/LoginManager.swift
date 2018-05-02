//
//  LoginManager.swift
//  Health
//
//  Created by Yalin on 15/8/18.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

struct LoginManager {
    
    static var isLogin: Bool {
        get {
            
            let userData = UserData.sharedInstance
            if userData.userId != nil {
                return true
            }
            else {
                return false
            }
        }
    }
    
    static var isShowAds: Bool {
        get {
            return false
        }
    }
    
    // 通过手机号 和 验证码登录
    static func login(_ phone: String?, captchas: String?, complete: ((NSError?) -> Void)?) {
        
        if phone == nil || captchas == nil || captchas == "" || phone == ""{
            complete?(NSError(domain: "登录", code: 0, userInfo: [NSLocalizedDescriptionKey:"手机号或验证码不能为空"]))
            return
        }
        
//        LoginRequest.login(phone!, captchas: captchas!) { (userInfo: [String: AnyObject]?, error: NSError?) -> Void in
//            // deal userInfo
//            if error == nil {
//                parseUserInfo(userInfo!)
//            }
//            complete?(error)
//        }
    }
    
    // 获取验证码
    static func queryCaptchas(_ phone: String?, complete: ((String?, NSError?) -> Void)?) {
        
        if phone == nil || phone == "" {
            complete?("", NSError(domain: "获取验证码", code: 0, userInfo: [NSLocalizedDescriptionKey:"手机号不能为空"]))
            return
        }
        
//        LoginRequest.queryCaptchas(phone!, complete: { (authCode: String?, error: NSError?) -> Void in
//            complete?(authCode,error)
//        })
    }
    
    
    
    // 完善信息
    static func completeInfomation(_ name: String, gender: Bool, birthday: String, height: UInt8, phone: String?, organizationCode: String?, headURL: String?, complete: @escaping ((_ error: NSError?) -> Void)) {
        
        if UserData.sharedInstance.userId == nil {
            complete(NSError(domain: "\(#function)", code: 0, userInfo: [NSLocalizedDescriptionKey: "未登录请先登录"]))
            return
        }
        
//        UserRequest.completeUserInfo(Int(UserData.sharedInstance.userId!), gender: gender, height: height, birthday: birthday, name: name, phone: phone, organizationCode: organizationCode, imageURL: headURL) { (imageURLStr, error) -> Void in
//
//            if headURL != nil {
//                _ = try? FileManager.default.removeItem(atPath: headURL!)
//            }
//
//            if error == nil {
//                UserData.sharedInstance.name = name
//                UserData.sharedInstance.gender = gender
//                UserData.sharedInstance.birthday = birthday
//                UserData.sharedInstance.height = height
//
//                UserData.sharedInstance.phone = phone
//                UserData.sharedInstance.organizationCode = organizationCode
//
//                UserData.sharedInstance.headURL = imageURLStr
//            }
//
//            complete(error)
//        }
    }
    
    static func uploadHeadIcon(_ imageURL: URL, complete: ((_ error: NSError?) -> Void)) {
        if UserData.sharedInstance.userId == nil {
            complete(NSError(domain: "\(#function)", code: 0, userInfo: [NSLocalizedDescriptionKey: "未登录请先登录"]))
            return
        }
    }
    
    // 登出
    static func logout() {
        UserData.sharedInstance.clearDatas()
    }
    
    
    
    static func parseUserInfo(_ userInfo: [String: AnyObject]) {
        
        
        if let userId = userInfo["userId"] as? String {
            print("userId\(userId)")
            UserData.sharedInstance.userId = NSString(string: userId).integerValue
        }
        
        
        if let phone = userInfo["phone"] as? String {
            print("mobile\(phone)")
            UserData.sharedInstance.phone = phone
//            if phone != 0 {
//                UserData.sharedInstance.phone = phone.stringValue
//            }
        }
        
        if let birthday = userInfo["birthday"] as? String {
            print("birthday\(birthday)")
            UserData.sharedInstance.birthday = birthday
        }
        
        if let gender = userInfo["gender"] as? NSString {
            print("gender\(gender)")
            UserData.sharedInstance.gender = gender.intValue == 1 ? true : false
        }
        
        if let head = userInfo["headURL"] as? String {
            print("head\(head)")
            UserData.sharedInstance.headURL = head
        }
        
        if let height = userInfo["height"] as? NSString {
            print("height\(height)")
            
            UserData.sharedInstance.height = UInt8(height.intValue)
        }
        
        if let name = userInfo["name"] as? String {
            print("name\(name)")
            UserData.sharedInstance.name = name
        }
    }
}
