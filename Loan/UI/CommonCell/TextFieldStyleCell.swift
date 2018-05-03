//
//  TextFieldStyleCell.swift
//  Loan
//
//  Created by gaowei on 2018/5/3.
//  Copyright © 2018年 yyl. All rights reserved.
//

import UIKit



class TextFieldStyleCell: UITableViewCell, CellStyleProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var viewModel: CellStyleModel?

    func setData(data: Any?, title: String?) {
        textField.resignFirstResponder()
        if let type = data as? UIKeyboardType {
            textField.keyboardType = type
        }
        
        self.titleLabel.text = title
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self, selector: #selector(resignNoti), name: NSNotification.Name(rawValue: CellStyleModel.keyboardResignNotification), object: nil)
    }
    
    @objc func resignNoti() {
        self.textField.resignFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
