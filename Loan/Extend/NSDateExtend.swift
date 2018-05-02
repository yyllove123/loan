//
//  NSDateExtend.swift
//  Health
//
//  Created by Yalin on 15/9/6.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import Foundation

extension Date {
    // 获取零点时间
    func zeroTime() -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let nowDateString = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: nowDateString)
        
        return date!
    }
    
    func secondTimeInteval() -> Int {
        return Int(self.timeIntervalSince1970)
    }
    
    func currentZoneFormatDescription() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func YYdd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func YYMMdd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
    func YYMMddHHmm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func MMddHHmm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日 HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func age() -> Int {
        return Date().year() - self.year()
    }
    
    init?(timescampStr: String) {
        var time: TimeInterval = 0
        if (timescampStr as NSString).length > 10 {
            time = (timescampStr as NSString).doubleValue / 1000
        }
        else {
            time = (timescampStr as NSString).doubleValue
        }
        
        self = Date(timeIntervalSince1970: TimeInterval(time))
    }
    
    /// 魔幻的时间显示
    ///  1、当天的资讯或文档，时间格式为 "HH:mm"
    ///  2、如果是昨天的资讯或文档，时间显示为 ”昨天“
    ///  3、如果是昨天以前的资讯或文档，时间显示为”MM-dd“
    ///  4、如果是跨年前的资讯或文档，时间显示为”yyyy-MM-dd“
    ///
    /// - Returns: 显示的字符串
    func magicShowDate() -> String {
        let todayZero = Date().zeroTime()
        let yesterdayZero = todayZero.addingTimeInterval(-24 * 60 * 60)
        let yesteryearZero = todayZero.addingTimeInterval(-365 * 24 * 60 * 60)
        
        if todayZero.compare(self) == .orderedAscending {
            return formatString("HH:mm")
        }
        
        if yesterdayZero.compare(self) == .orderedAscending {
            return "昨天"
        }
        
        if yesteryearZero.compare(self) == .orderedAscending {
            return formatString("MM-dd")
        }
        
        return formatString("yyyy-MM-dd")
    }
    
    
    /// 指定格式的日期字符串
    ///
    /// - Parameter format: 格式
    /// - Returns: 字符串
    func formatString(_ format: String) -> String {
        let formate = DateFormatter()
        formate.dateFormat = format
        return formate.string(from: self)
    }
    
    
    /// 获取星期几字符串
    ///
    /// - Returns: "星期天" 、"星期一"
    func weekDayStr() -> String {
        
        let weekdays = ["", "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier:"Asia/Shanghai")!
        
        let theComponents = calendar.dateComponents(Set(arrayLiteral: .weekday), from: self)
        return weekdays[theComponents.weekday!]
    }
    
    func year() -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier:"Asia/Shanghai")!
        
        let theComponents = calendar.dateComponents(Set(arrayLiteral: .year), from: self)
        return theComponents.year!
    }
}
