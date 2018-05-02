//
//  UIView_ConvertToImage.swift
//  Health
//
//  Created by Yalin on 15/10/9.
//  Copyright © 2015年 Yalin. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore


/*
 -(UIImage*)convertViewToImage:(UIView*)v{
 CGSize s = v.bounds.size;
 // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
 UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
 [v.layer renderInContext:UIGraphicsGetCurrentContext()];
 UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return image;
 }
 */

extension UIView {
    func convertToImage() -> UIImage {
        let s = self.bounds.size
        UIGraphicsBeginImageContextWithOptions(s, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension UIColor {
    
    func toImage() -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /*
     - (UIImage*) createImageWithColor: (UIColor*) color
     {
     CGRect rect=CGRectMake(0,0, 1, 1);
     UIGraphicsBeginImageContext(rect.size);
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetFillColorWithColor(context, [color CGColor]);
     CGContextFillRect(context, rect);
     UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return theImage;
     }
 */
}
