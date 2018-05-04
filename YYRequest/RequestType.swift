//
//  RequestType.swift
//  Health
//
//  Created by Yalin on 15/9/8.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

enum RequestType: String {
    
    // Login
    case Login = "user/login.do"
    case QueryRegisterUserCaptchas = "user/getCode.do"
    case RegisterUser = "user/seregist.do"
    case QueryForgetPwdCaptcha = "user/getMissPsw.do"
    case VerifyForgetPwdCaptcha = "user/mispasNextVal.do"
    case ForgetPwdChange = "user/editMisPsw.do"
    case UpdateUserHeadImage = "user/updateAvatar.do"
    case GetByKey = "sysDic/getBykey.do?key=register_recommand"
    
    // Home Page
    case HomeBannerList = "homepage/list.do"
    case HomeGoodsList = "homepage/prolist.do"
    case QueryGoodInfo = "projectInfo/selectDetails.do"
    case QueryProjectRewardList = "projectReward/selectProjectReward.do"
    case QueryProjectRewardInfo = "projectReward/selectProjectRewardInfo.do"
    case QueryRiskContent = "projectInfo/selectRisk.do"
    case QueryProjectCategoryList = "initProject/getProjectCategoryInfo.do"
    
    // Order
    case QueryOrderList = "product/listOrder.do"
    case QueryOrderInfo = "order/getOrderInfo.do"
    case AddOrder = "order/addOrder.do"
    case DeleteOrder = "product/deleteOrder.do"
    
    // pay
    case PayConfirm = "pay/payConfirm.do"
    
    // Address
    case QueryAddressList = "address/address.do"
    case setDefaultAddress = "address/setDefault.do"
    case addAddress = "address/addAddress.do"
    case deleteAddress = "address/delAddress.do"
    
    // Coupon
    case QueryCoupons = "projectCoupon/myCouponClient.do"
    case QueryMyCouponList = "projectCoupon/toMyCouponList.do"
    case GetCoupon = "projectCoupon/takeCoupon.do"
    
    
    func startRequest(_ params: [String : Any], completionHandler: @escaping (_ data: Data? , _ response: URLResponse?, _ error: NSError?) -> Void) {
        Request.startWithRequest(self, params: params, completionHandler: completionHandler)
    }
    
    func startRequest1(_ params: [String : Any], completionHandler: @escaping (_ jsonObj: Any?, _ err: NSError?) -> Void) {
        Request.start1WithRequest(self, params: params, completionHandler: completionHandler)
    }
}


enum ThirdPlatformType: String {
    case WeChat = "0"
    case QQ = "1"
    case Weibo = "2"
    
}

