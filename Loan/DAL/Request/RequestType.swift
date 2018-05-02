//
//  RequestType.swift
//  Health
//
//  Created by Yalin on 15/9/8.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

enum RequestType: String {
    case Login = "apploginAction.action"
    case QueryCaptchas = "appLoginVerifCodeAction.action"
    case LoginThirdPlatform = "app3loginAction.action"
    case BindThirdPlatform = "addTUserBindingAction.action"
    case CancelBindThirdPlatform = "delTUserBindingAction.action" // 解除绑定接口  传 userId 和  openId 的值就行
    case UploadPushToken = ""
    
    case CreateUser = "appNewSubUserAction.action"
    case DeleteUser = "appdelSubuserAction.action"
    case CompleteUserInfo = "appUpdateUserAction.action"
    case QueryUserInfo = "appQuerySubUserAction.action"
    
    case QueryEvaluationDatas = "TProfiledataInterfQueryAction.action"
    case UploadEvaluationDatas = "addDataAction.action"
    case DeleteEvaluationData = "delDataIdsAction.action"
    case DeleteEvaluationDatas = "100015"
    
    case QueryDeviceTypeDatas = "queryDeviceAction.action"
    case QueryBindDeviceTypeDatas = "TUserDeviceQueryAction.action"
    case AddBindDevice = "addDeviceAction.action"
    case DeleteBindDevice = "delDeviceAction.action"
    
    case QueryMessageList = "queryMsgAction.action"
    
    case QueryFindMsgList = "queryInformateAction.action"
    case LikeFindMsg = "updateisLikeAction.action"
    case CollectFindMsg = "updateisCollectionAction.action"
    case QueryFindCollectList = "queryIsCollectionAction.action"
    case QueryFindAds = "queryPictureAction.action"
    
    case QueryGoalDatas = "100020"
    case UploadGoalDatas = "100019"
    case DeleteGoalData = "100021"
    case DeleteGoalDatas = "100024"
    
    case UploadSettingGoalDatas = "100031"
    case QuerySettingGoalDatas = "100032"
    
    case QueryScore = "100017"
    case Share = "100018"
    case QueryBadge = "100029"  // 获取徽章 传userId
    
    case QueryLaunchAds = "100011"
    case QueryActivityAds = "100012"
    
    case FeedBack = "addTUserFeedbackAction.action"
    
    case CheckAppVersion = "appToUpdateAction.action"
    
    func startRequest(_ params: [String : Any], completionHandler: @escaping (_ data: Data? , _ response: URLResponse?, _ error: NSError?) -> Void) {
        Request.startWithRequest(self, params: params, completionHandler: completionHandler)
    }
}


enum ThirdPlatformType: String {
    case WeChat = "0"
    case QQ = "1"
    case Weibo = "2"
    
}

