//
//  Crypto.swift
//  Health
//
//  Created by Yalin on 15/9/8.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import Foundation
//import CommonCrypto

// 需要在桥接文件中引入  #import <CommonCrypto/CommonDigest.h>

/*
/*
* MD5
*/
CG_INLINE NSString* MD5FromString(NSString *sourceString)
{
    const char *original_str = [sourceString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
*/

extension String {
    var md5Value: String {
        
//        print("md5 String: \(self)")
        let original_str = self.cString(using: String.Encoding.utf8)
//        let original_str = (NSString(string: self).data(using: String.Encoding.utf8)! as NSData).bytes
        
        var result: [CUnsignedChar] = [CUnsignedChar](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(original_str, CC_LONG(self.data(using: String.Encoding.utf8, allowLossyConversion: false)!.count), &result)
        
        let hash = NSMutableString()
        for index in 0...15 {
            hash.appendFormat("%02x", result[index])
        }
        
        return String(hash.lowercased)
    }
    
    var urlEncodeValue: String {
        
        /*
         private static final String[][] query_convert = {
         { "%", "%25" },
         { "=", "%3D" },
         { "?", "%3F" },
         { "&", "%26" },
         { ">", "%3E" },
         { "<", "%3C" },
         { "\"", "%22" },
         { "'", "%27" },
         { ";", "%3B" },
         { ":", "%3A" },
         { "/", "%2F" },
         { "\\", "%5C" },
         { "(", "%28" },
         { ")", "%29" },
         { "[", "%5B" },
         { "]", "%5D" },
         { "{", "%7B" },
         { "}", "%7D" },
         { "#", "%23" },
         { "!", "%21" },
         { "+", "%2B" },
         { " ", "+" },
         { "$", "%24" },
         { "^", "%5E" },
         { ",", "%2C" },
         { "~", "%7E" },
         { "`", "%60" },
         { "|", "%7C" }, 
         { "＞", "%A3%BE" }, 
         { "＜", "%A3%BC" }, 
         { "\n", "%0A" }, 
         { "\r", "%0D" } };
 */
        
        if let value = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return value.replacingOccurrences(of: "+", with: "%2B").replacingOccurrences(of: ":", with: "%3A")
        }
        return self
    }
    
    var urlDecodeValue: String {
        
        /*
         private static final String[][] from_query_convert = {
         { "%3D", "=" },
         { "%3F", "?" },
         { "%26", "&" },
         { "%3E", ">" },
         { "%3C", "<" },
         { "%22", "\"" },
         { "%27", "'" },
         { "%3B", ";" },
         { "%3A", ":" },
         { "%2F", "/" },
         { "%5C", "\\" },
         { "%28", "(" },
         { "%29", ")" },
         { "%5B", "[" },
         { "%5D", "]" },
         { "%7B", "{" },
         { "%7D", "}" },
         { "%23", "#" },
         { "%21", "!" },
         { "%24", "$" },
         { "%5E", "^" },
         { "+", " " },
         { "%2B", "+" },
         { "%2C", "," },
         { "%7E", "~" },
         { "%60", "`" }, 
         { "%7C", "|" }, 
         { "%0D", "\r" }, 
         { "%0A", "\n" }, 
         { "%25", "%" } };
 */
        
        if let value = self.removingPercentEncoding {
            return value
        }
        return self
    }
    
}
