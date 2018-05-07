//
//  UIViewController_HUD.swift
//  Loan
//
//  Created by gaowei on 2018/5/7.
//  Copyright © 2018年 yyl. All rights reserved.
//

import Foundation
import UIKit

// 需要在桥接文件中引入第三方库 #import <MBProgressHUD/MBProgressHUD.h>

enum HUDType {
    case hotwheels  // 只有一个风火轮,加文字
    case progress   // 初始化通讯录时有进度条
    case onlyMsg     // 只有文字
}

extension UIViewController {
    
    func updateHUD(_ type: HUDType, message: String?, detailMsg: String?, progress: Float?) {
        
        let progressHUD = HUDManager.shareInstance.queryHUD(controller: self, isInWindow: true)
        
        switch type {
        case .hotwheels:
            progressHUD.labelText = message
            progressHUD.detailsLabelText = detailMsg
            progressHUD.mode = MBProgressHUDMode.indeterminate
        case .onlyMsg:
            progressHUD.labelText = message
            progressHUD.detailsLabelText = detailMsg
            progressHUD.mode = MBProgressHUDMode.text
        case .progress:
            progressHUD.labelText = message
            progressHUD.detailsLabelText = detailMsg
            progressHUD.mode = MBProgressHUDMode.determinateHorizontalBar
        }
        
        if !HUDManager.shareInstance.isShowingHUD {
            UIApplication.shared.keyWindow?.addSubview(progressHUD)
            progressHUD.show(true)
            HUDManager.shareInstance.isShowingHUD = true
        }
    }
    
    func hiddenHUD() {
        HUDManager.shareInstance.isShowingHUD = false
        HUDManager.shareInstance.queryHUD(controller: self, isInWindow: true).hide(true)
        HUDManager.shareInstance.clearHUD(controller: self)
    }
    
}

fileprivate class HUDManager {
    static let shareInstance = HUDManager()
    
    var huds: [String : MBProgressHUD] = [:]
    fileprivate var isShowingHUD: Bool = false
    
    func queryHUD(controller: UIViewController, isInWindow: Bool) -> MBProgressHUD {
        
        let key = addressString(obj: controller) + "_\(isInWindow)"
        
        if let hud = huds[key] {
            return hud
        }
        
        var hud: MBProgressHUD? = nil
        if isInWindow {
            hud = MBProgressHUD(window: UIApplication.shared.windows.first!)
        }
        else {
            hud = MBProgressHUD(view: controller.view)
        }
        
        huds[key] = hud
        
        return hud!;
    }
    
    func clearHUD(controller: UIViewController) {
        
        huds[addressString(obj: controller) + "_\(true)"] = nil
        huds[addressString(obj: controller) + "_\(false)"] = nil
        
    }
    
    private func addressString(obj: AnyObject) -> String {
        
        return "\(Unmanaged<AnyObject>.passUnretained(obj).toOpaque())"
    }
}
