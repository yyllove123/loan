//
//  PasswordTextFieldCell.swift
//  Loan
//
//  Created by gaowei on 2018/5/3.
//  Copyright © 2018年 yyl. All rights reserved.
//

import UIKit

class PasswordTextFieldStyleCell: UITableViewCell, CellStyleProtocol {
    
    var viewModel: CellStyleModel?
    func setData(data: Any?, title: String?) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
