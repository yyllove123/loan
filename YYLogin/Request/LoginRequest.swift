//
//  YYLoginRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

struct  LoginRequest {
    
    // 通过用户名密码登录
    static func login(_ username: String, password: String, autoLogin: Bool, complete : @escaping (([String: AnyObject]? , NSError?) -> Void)) {
        
        RequestType.Login.startRequest(["mobile" : username, "password" : password, "autoLogin" : autoLogin ? "1" : "0"]) { (data: Data?, response: URLResponse?, error: NSError?) in
            let result = Request.dealResponseData(data, response: response, error: error)
            if let err = result.error {
                complete(nil, err)
                #if DEBUG
                    print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                #endif
            }
            else {
                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                complete(jsonObj as! [String : AnyObject]?, nil)
                #if DEBUG
                    print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
                #endif
            }
        }
        
    }
    
    static func registerUser(phone: String, captcha: String, password: String, inviteCode: String, orgazationCode: String?, complete : @escaping (([String: AnyObject]? , NSError?) -> Void)) {
        
        RequestType.RegisterUser.startRequest([
            "mobile" : phone,
            "code" : captcha,
            "password" : password,
            "sponsorId" : inviteCode,
            "sourceType" : "ios",
            "placement" : orgazationCode != nil ? orgazationCode! : "",
        ]) { (data, response, error) in
            
            let result = Request.dealResponseData(data, response: response, error: error)
            if let err = result.error {
                complete(nil, err)
                #if DEBUG
                    print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                #endif
            }
            else {
                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                complete(jsonObj as! [String : AnyObject]?, nil)
                #if DEBUG
                    print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
                #endif
            }
        }
    }
    
    func uploadToken(userId: Int, pushToken: String, complete: @escaping ((NSError?) -> Void)) {
//        RequestType.UploadPushToken.startRequest(["userId" : userId, "pushToken" : pushToken , "platform" : "ios"]) { (data, response, error) in
//            let result = Request.dealResponseData(data, response: response, error: error)
//            if let err = result.error {
//                complete(err)
//                #if DEBUG
//                    print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
//                #endif
//            }
//            else {
//                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
//                complete(nil)
//                #if DEBUG
//                    print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
//                #endif
//            }
//        }
    }
    
    // 获取验证码
    static func queryCaptchas(_ phone: String, type: Int, complete: @escaping ((NSError?) -> Void)) {
        
        if type == 1 {
            RequestType.QueryRegisterUserCaptchas.startRequest(["mobile" : phone as AnyObject, "type" : 1], completionHandler: { (data, response, error) -> Void in
                let result = Request.dealResponseData(data, response: response, error: error)
                if let err = result.error {
                    complete(err)
                    #if DEBUG
                        print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                    #endif
                }
                else {
                    let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                    complete(nil)
                    #if DEBUG
                        print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
                    #endif
                }
            })
        }
        else if type == 2 {
            RequestType.QueryForgetPwdCaptcha.startRequest(["mobile" : phone as AnyObject, "type" : 1], completionHandler: { (data, response, error) -> Void in
                let result = Request.dealResponseData(data, response: response, error: error)
                if let err = result.error {
                    complete(err)
                    #if DEBUG
                        print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                    #endif
                }
                else {
                    let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                    complete(nil)
                    #if DEBUG
                        print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
                    #endif
                }
            })
        }
        
    }
    
    static func findForgetPwd(phone: String, password: String, captcha: String, complete: @escaping ((NSError?) -> Void)) {
        
        RequestType.VerifyForgetPwdCaptcha.startRequest1(["mobile" : phone, "type" : 1, "code" : captcha, "webcode" : 1]) { (jsonObject, error) in
            
            if error == nil {
                
                RequestType.ForgetPwdChange.startRequest1(["phone" : phone, "password" : password], completionHandler: { (jsonObject, error) in
                    
                    complete(error)
                    
                })
                
            }
            else {
                complete(error)
            }
        }
    }
    
    static func updateHeadImage(imageUrlStr: String, complete: @escaping ((NSError?) -> Void)) {
        
        RequestType.UpdateUserHeadImage.startRequest1(["id": UserData.sharedInstance.userId! , "avatar" : imageUrlStr]) { (jsonObj, error) in
            
            complete(error)
        }
        
    }
    
    // 第三方登录
    static func loginThirdPlatform(_ name: String, headURLStr: String, openId: String, type: ThirdPlatformType, unionid: String?, complete: @escaping ((_ userInfo: [String: AnyObject]?, NSError?) -> Void)) {
        
        
        
        var info = ["openId": openId, "type": type.rawValue]
        
        if name != "" {
            info["name"] = name
        }
        
        if headURLStr != "" {
            info["headURL"] = headURLStr
        }
        
        if unionid != nil {
            info["token"] = unionid
        }
        // , token: String?
//        if token != nil {
//            info["token"] = token
//        }
        
//        RequestType.LoginThirdPlatform.startRequest(info as [String : AnyObject], completionHandler: { (data, response, error) -> Void in
//            
//            let result = Request.dealResponseData(data, response: response, error: error)
//            if let err = result.error {
//                complete(nil, err)
//                #if DEBUG
//                    print("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
//                #endif
//            }
//            else {
//                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
//                complete(jsonObj as! [String : AnyObject]?, nil)
//                #if DEBUG
//                    print("\n----------\n\(#function) \nresult \(String(describing: jsonObj))\n==========")
//                #endif
//            }
//        })
    }
}


