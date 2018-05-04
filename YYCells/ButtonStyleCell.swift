//
//  Normal1TableViewCell.swift
//  Loan
//
//  Created by gaowei on 2018/5/3.
//  Copyright © 2018年 yyl. All rights reserved.
//

import UIKit

class ButtonStyleCell: UITableViewCell, CellStyleProtocol {
    
    @IBOutlet weak var button: UIButton!
    var viewModel: CellStyleModel?
    
    func setData(data: Any?, title: String?) {
        self.button.setTitle(title, for: UIControlState.normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonPressed(_ sender: Any) {
        self.viewModel!.block?(self.viewModel!, self.viewModel!.controller)
    }
}
