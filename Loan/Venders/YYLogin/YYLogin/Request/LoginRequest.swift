//
//  YYLoginRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

struct  LoginRequest {
    
    static func login(datas: [String: Any], complete : @escaping (([String: AnyObject]? , NSError?) -> Void)) {
        
        guard let username = datas["username"] else {
            complete(nil, NSError(domain: "LoginRequest", code: 10001, userInfo: [NSLocalizedDescriptionKey : "用户名没传"]))
            return
        }
        
        guard let password = datas["password"] else {
            complete(nil, NSError(domain: "LoginRequest", code: 10001, userInfo: [NSLocalizedDescriptionKey : "密码没传"]))
            return
        }
        
        RequestType.Login.startRequest(["mobile" : username, "password" : password]) { (data: Data?, response: URLResponse?, error: NSError?) in
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
    
    static func registerUser(datas: [String : Any], complete : @escaping (([String: AnyObject]? , NSError?) -> Void)) {
        
        let username = datas["username"]!
        let captcha = datas["captcha"]!
        let password = datas["password"]!
        
        RequestType.RegisterUser.startRequest([
            "username" : username,
            "code" : captcha,
            "password" : password,
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
    
    static func findForgetPwd(datas: [String : Any], complete: ((NSError?) -> Void)?) {
        
        let phone = datas["phone"]!
        let captcha = datas["captcha"]!
        let password = datas["password"]!
        
        RequestType.VerifyForgetPwdCaptcha.startRequest1(["mobile" : phone, "type" : 1, "code" : captcha, "webcode" : 1]) { (jsonObject, error) in
            
            if error == nil {
                
                RequestType.ForgetPwdChange.startRequest1(["phone" : phone, "password" : password], completionHandler: { (jsonObject, error) in
                    
                    complete?(error)
                    
                })
                
            }
            else {
                complete?(error)
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


