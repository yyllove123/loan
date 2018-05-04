//
//  YYRequest.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/4.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import Foundation

struct Request {
    
//    static func requestURL(_ type : String) -> String {
//        let urlString = "http://www.gaijubao.com/gjb-service-v1/\(type)"
//        return urlString
//    }
//    
//    
//    
//    static func startWithRequest(_ url : String, method : String?, params : [String : String]?, completionHandler:  @escaping (_ data: Data? , _ response: URLResponse?, _ error: NSError?) -> Void) {
//        
//        // create request
//        var request : URLRequest = URLRequest(url: URL(string: url)!)
//        
//        if let m = method {
//            request.httpMethod = m
//        }
//        
//        // set body data
//        if let bodyStrAndBoundary = generateFormDataBodyStr(params) {
//            request.httpBody = bodyStrAndBoundary.bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
//            request.setValue("\(bodyStrAndBoundary.bodyStr.lengthOfBytes(using: String.Encoding.utf8))", forHTTPHeaderField: "Content-Length")
//            request.setValue("multipart/form-data; boundary=Boundary+\(bodyStrAndBoundary.boundary)", forHTTPHeaderField: "Content-Type")
//        }
//        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: NSError?) -> Void in
//            DispatchQueue.main.async(execute: { () -> Void in
//                completionHandler(data, response, self.errorFilter(error))
//            })
//        } as! (Data?, URLResponse?, Error?) -> Void)
//        
//        task.resume()
//    }
}

// PHP Style
extension Request {
    
    static func requestFilePath() -> String {
        return "http://testgjb.91anshi.cn/gjb-service-v1"
//        return "http://www.gaijubao.com/gjb-service-v1"
    }
    
    static func requestPHPURL(type: RequestType) -> String {
        return "\(Request.requestFilePath())/\(type.rawValue)"
    }
    
    static func start1WithRequest(_ requestType: RequestType, params: [String : Any], completionHandler: @escaping (_ jsonObj: Any?, _ err: NSError?) -> Void) {
        
        startWithRequest(requestType, params: params) { (data, response, error) in
            
            let result = Request.dealResponseData(data, response: response, error: error)
            if let err = result.error {
                completionHandler(nil, err)
                #if DEBUG
                    print("\n----------\n\(requestType.rawValue) \nerror:\(err.localizedDescription)\n==========")
                #endif
            }
            else {
                completionHandler(result.jsonObj, nil)
                #if DEBUG
                    print("\n----------\n\(requestType.rawValue) \nresult \(String(describing: result.jsonObj))\n==========")
                #endif
            }
        }
    }
    
    static func startWithRequest(_ requestType: RequestType, params: [String : Any], completionHandler: @escaping (_ data: Data? , _ response: URLResponse?, _ error: NSError?) -> Void) {
        // create request
        var request : URLRequest = URLRequest(url: URL(string: requestPHPURL(type: requestType))!)
        request.httpMethod = "POST"
        request.timeoutInterval = 15
        
        let requestParams = params
        // timeScamp
//        let timeInterval = Date().timeIntervalSince1970
//        requestParams["timestamp"] = Int(1483943509)
//        requestParams["timestamp"] = Int(timeInterval)
        
        // sign
//        requestParams["sign"] = sign(params: requestParams) as AnyObject?
        
        
//        setRequestHeader(request: &request, params: requestParams)
        // set body data
        print("requestType: \(requestType.rawValue)")
        print("request: \(request)")
        request.httpBody = generateFormTextBodyStr(params: requestParams).data(using: String.Encoding.utf8, allowLossyConversion: true)
//        if let bodyStrAndBoundary = generateFormDataBodyStr(requestParams) {
//            request.httpBody = bodyStrAndBoundary.bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
//            request.setValue("\(bodyStrAndBoundary.bodyStr.lengthOfBytes(using: String.Encoding.utf8))", forHTTPHeaderField: "Content-Length")
//            request.setValue("multipart/form-data; boundary=\(bodyStrAndBoundary.boundary)", forHTTPHeaderField: "Content-Type")
//        }
        
//        request.httpBody = generatePHPStyleBodyStr(requestType.rawValue, params: params).data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: Error?) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                
                var err = error
                
                let httpresponse = response as? HTTPURLResponse
                print("statusCode: \(String(describing: httpresponse?.statusCode))")
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                        err = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : "Error with request: \(request) error: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)) statusCode: \(httpResponse.statusCode)"]) as Error
                    }
                }
                
                completionHandler(data, response, self.errorFilter(err as NSError?))
            })
        })
        
        task.resume()
    }
    
    static func setRequestHeader( request: inout URLRequest, params: [String : Any]) {
        
        for (key, value) in params {
            request.setValue("\(value)", forHTTPHeaderField: key)
        }
    }
    
    static func sign(params: [String : Any]) -> String {
        let allKeys = params.keys.sorted { (key1: String, key2: String) -> Bool in
            return key1.compare(key2) == .orderedAscending
        }
        
        if allKeys.count == 0 {
            
        }
        
        var singStr = ""
        for i in 0...allKeys.count-1 {
            let key = allKeys[i]
            if key != "head" && key != "headURL" {
                singStr += "\(key)\(params[key]!)"
            }
        }
        
        let key = "2342342vcsd464"
        singStr += key
        
        print("singStr: \(singStr)")
        return singStr.md5Value
    }
    
    static func generateFormTextBodyStr(params: [String : Any]) -> String {
        var bodyStr: [String] = []
        for (key, value) in params {
            
            bodyStr += ["\(key)=\("\(value)".urlEncodeValue)"]
            
        }
        
        print("sendBodyStr: \((bodyStr as NSArray).componentsJoined(by: "&"))")
        return (bodyStr as NSArray).componentsJoined(by: "&")
    }
    
    static func generatePHPStyleBodyStr(_ partnerCode: String, params: [String : AnyObject]) -> String {
        var error: NSError? = nil
        
        let key = "04c67a23b87bc349cfdf8fa59e980723"
        let timeInterval = Date().timeIntervalSince1970
        let md5Key = String(format: "%i%@", arguments: [Int(timeInterval), key]).md5Value
        
        let httpBodyInfo = [
            "header" : [
                "timestamp" : Int(timeInterval),
                "key" : md5Key,
                "partnerCode" : partnerCode,
                "encryption" : "md5"
            ],
            "body" : params
        ] as [String : Any]
        
        print("request HTTPBody \(httpBodyInfo)")
        
        
        var httpBodyData: Data?
        do {
            httpBodyData = try JSONSerialization.data(withJSONObject: httpBodyInfo, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let error1 as NSError {
            error = error1
            httpBodyData = nil
        }
        if error != nil {
            assert(true, error!.description)
        }
        
        return String(NSString(data: httpBodyData!, encoding: String.Encoding.utf8.rawValue)!)
    }
}

// data wrapper
extension Request {
    
    static func generateFormDataBodyStr(_ params : [String : Any]?) -> (bodyStr : String, boundary : String)? {
        
        let boundary = String(format: "%08X%08X", arc4random(),arc4random())
        // add form data
        var bodyStr = "--\(boundary)--\r\n"
        if let p = params {
            for (key , value) in p {
                bodyStr += "--\(boundary)\r\nContent-Disposition: form-data; name=\"\(key)\"; Content-Type: text/plain\r\n\r\n\(value)\r\n"
            }
        }
        else {
            return nil
        }
        bodyStr += "\r\n--\(boundary)--\r\n"
        
        print("bodyData: \(bodyStr)")
        return (bodyStr, boundary)
    }
    
    
}

// error filter
extension Request {
    
    fileprivate static func errorFilter(_ error : NSError?) -> NSError? {
        return error
    }
}
