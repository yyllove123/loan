//
//  ResponseDataFilter.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/15.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import Foundation

extension Request {
    
    static func dataFilter(_ data: Data!) -> (jsonObj : AnyObject? , error : NSError?) {
        
        var err : NSError?
        
        do {
            let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            var filterStr = jsonStr!.replacingOccurrences(of: "\n", with: "\\n")
            filterStr = jsonStr!.replacingOccurrences(of: "\r", with: "\\r")
            print("responseJson\(String(describing: jsonStr))")
            
            let result : NSDictionary? = try JSONSerialization.jsonObject(with: filterStr.data(using: String.Encoding.utf8)!,  options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            let message: AnyObject? = result?.value(forKey: "msg") as AnyObject?
            print("responseStr: \(String(describing: result)) \(String(describing: message))")
            
            if let jsonObj = result {
                
                if let code = jsonObj.value(forKey: "errorCode") as? String {
                    if code == "0" {
                        // 请求成功
                        
                        if let data = jsonObj.value(forKey: "info") as? [String : Any] {
                            let filterResult: NSMutableDictionary = NSMutableDictionary(capacity: 0)
                            for (key, value) in data {
                                
                                if let strValue = value as? String {
                                    if strValue == "" || strValue == "null" {
//                                        continue
                                    }
                                }
                                filterResult.setValue(value, forKey: key)
                            }
                            return (filterResult, nil)
                        }
                        else if let data = jsonObj.value(forKey: "info") as? [[String : Any]] {
                            var filterResult: [[String : Any]] = []
                            
                            for info in data {
                                var tempInfo = info
                                
                                for (key, value) in info {
                                    if let strValue = value as? String {
                                        if strValue == "" || strValue == "null" {
//                                            continue
                                        }
                                    }
                                    tempInfo[key] = value
                                }
                                filterResult.append(tempInfo)
                            }
                            return (filterResult as AnyObject, nil)
                        }
                        else {
                            return (jsonObj, nil)
                        }
                        
                    }
                    else {
                        // 请求失败
                        if let msg = jsonObj.value(forKey: "msg") as? String {
                            err = NSError(domain: "Server logic error", code: (code as NSString).integerValue, userInfo: [NSLocalizedDescriptionKey : msg])
                        }
                        else
                        {
                            err = NSError(domain: "Server logic error", code: (code as NSString).integerValue, userInfo: [NSLocalizedDescriptionKey : "Server not return the detail error message"])
                        }
                    }
                }
            }
            return (nil, err)
        } catch let error1 as NSError {
            return (nil, error1)
        }
    }
    
    // 处理返回数据
    static func dealResponseData(_ data: Data!, response: URLResponse!, error: NSError!) -> (jsonObj : AnyObject? , error : NSError?) {
        if let err = error {
            return (nil, err)
        }
        else {
            let result = Request.dataFilter(data)
            return result
        }
    }
}
