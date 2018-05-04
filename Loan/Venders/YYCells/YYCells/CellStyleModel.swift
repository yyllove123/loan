//
//  CellStyle.swift
//  Loan
//
//  Created by gaowei on 2018/5/3.
//  Copyright © 2018年 yyl. All rights reserved.
//

import Foundation
import UIKit

struct CellStyleModel {
    
    var style: CellStyle
    var title: String?
    
    var data: Any?
    var block: ((CellStyleModel, UIViewController) -> Void)?
    var controller: UIViewController
    
    static let keyboardResignNotification = "kKeyboardResignNotification"
    
    
    init(style: CellStyle, title: String?, data: Any?, controller: UIViewController, block: ((CellStyleModel, UIViewController) -> Void)?) {
        self.style = style
        self.title = title
        self.data = data
        self.controller = controller
        self.block = block
    }
    
    static func registerCells(tableView: UITableView) {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        tableView.register(UINib(nibName: CellStyle.Button.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.Button.identifier())
        tableView.register(UINib(nibName: CellStyle.FullImageView.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.FullImageView.identifier())
        tableView.register(UINib(nibName: CellStyle.PasswordTextField.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.PasswordTextField.identifier())
        tableView.register(UINib(nibName: CellStyle.TextField.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.TextField.identifier())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, data: Any?) -> UITableViewCell{
        if var cell = tableView.dequeueReusableCell(withIdentifier: self.style.identifier(), for: indexPath) as? CellStyleProtocol {
            cell.viewModel = self
            cell.setData(data: data, title: title)
            
            let cellView = cell as! UITableViewCell
            cellView.selectionStyle = .none
            return cellView
        }
        return tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        block?(self, controller)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(style.height())
    }
}

enum CellStyle {
    case Button
    case FullImageView
    case TextField
    case PasswordTextField
    
    func identifier() -> String {
        switch self {
        case .Button:
            return "ButtonStyleCell"
        case .FullImageView:
            return "FullImageViewStyleCell"
        case .PasswordTextField:
            return "PasswordTextFieldStyleCell"
        case .TextField:
            return "TextFieldStyleCell"
        }
    }
    
    func height() -> Float {
        switch self {
        case .Button:
            return 66.5
        case .FullImageView:
            return 66.5
        case .PasswordTextField:
            return 66.5
        case .TextField:
            return 66.5
        }
    }
}

protocol CellStyleProtocol {
    var viewModel: CellStyleModel?  { get set }
    func setData(data: Any?, title: String?)
}
