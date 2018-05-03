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
    var data: Any
    var block: ((Any, UIViewController) -> Void)?
    
    static func registerCells(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        tableView.register(UINib(nibName: CellStyle.Button.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.Button.identifier())
        tableView.register(UINib(nibName: CellStyle.FullImageView.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.FullImageView.identifier())
        tableView.register(UINib(nibName: CellStyle.PasswordTextField.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.PasswordTextField.identifier())
        tableView.register(UINib(nibName: CellStyle.TextField.identifier(), bundle: nil), forCellReuseIdentifier: CellStyle.TextField.identifier())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, data: Any?) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.style.identifier(), for: indexPath) as? CellStyleProtocol {
            cell.setData(data: data)
            return cell as! UITableViewCell
        }
        return tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, controller: UIViewController)
    {
        block?(data, controller)
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
}

protocol CellStyleProtocol {
    func setData(data: Any?)
}
