//
//  JDFormView.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/24.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit

class JDFormView: UIView {

    var leftName : String?
    var rightText : String?
    
    override func draw(_ rect: CGRect) {
        
        
        
        let leftl = UILabel()
        leftl.frame = CGRect(x:0,y:0,width:rect.size.width*0.27,height:50)
        leftl.textColor = UIColor.darkGray
        leftl.text=leftName
        leftl.textAlignment = NSTextAlignment.right
        leftl.font = JDMINFONT
        self.addSubview(leftl)
        
        
        
        let tf = UITextField()
        tf.frame = CGRect(x:leftl.right+rect.size.width*0.02,y:0,width:rect.size.width*0.71,height:50)
        tf.text=rightText
        tf.font = JDSTANDFONT
        self.addSubview(tf)
        
        self.backgroundColor  = UIColor.white
        
    }
    

}
