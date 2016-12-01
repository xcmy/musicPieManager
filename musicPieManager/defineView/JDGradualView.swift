//
//  JDGradualView.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/25.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit

class JDGradualView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
    */
    var endPoint : CGPoint?
    var startColor :UIColor?
    var endColor :UIColor?
    
    override func draw(_ rect: CGRect) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        
        gradientLayer.startPoint = CGPoint(x:0,y:0)
        gradientLayer.endPoint = endPoint!
        
        gradientLayer.colors = [startColor?.cgColor ?? JDCOLOR(hex: "#60696A").cgColor,endColor?.cgColor ?? JDCOLOR(hex: "#9CA4A4").cgColor ]
        self.layer.addSublayer(gradientLayer)
        
        
    }

    
}
