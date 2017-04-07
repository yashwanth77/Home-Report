//
//  HomeListTableViewCell.swift
//  Home Report
//
//  Created by Roger on 4/6/17.
//  Copyright © 2017 PFI. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var sqftLbl: UILabel!
    
    @IBOutlet weak var bathLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bedLbl: UILabel!
    @IBOutlet weak var homeImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
