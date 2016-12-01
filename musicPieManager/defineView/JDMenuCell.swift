//
//  JDMenuCell.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/25.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit

class JDMenuCell: UITableViewCell {

    var isExpend:Bool = true
    var subLabel :UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder:aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isExpend=true
        self.subLabel = UILabel(frame:JDRECT(xx: 30, yy: 0, w: self.contentView.width-30, h: 40))
        self.subLabel?.textColor = UIColor.white
        self.subLabel?.textAlignment = NSTextAlignment.left
        self.subLabel?.font = JDMINFONT
        self.addSubview(subLabel!)
        
        
    }
}
