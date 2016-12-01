//
//  prefixHeader.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/23.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit



let JDWIDTH = UIScreen.main.bounds.size.width
let JDHEIGHT = UIScreen.main.bounds.size.height

let JDBASE_URL = "http://192.168.0.115:8080/musicPie"


func JDRGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func JDRECT(xx:CGFloat,yy:CGFloat,w:CGFloat,h:CGFloat) -> CGRect {
    return CGRect(x: xx, y: yy, width: w, height: h)
}

let JDBORDERCOLOR = JDRGBA(r: 234, g: 234, b: 235, a: 1).cgColor


let JDSTANDFONT = UIFont.systemFont(ofSize: 18)
let JDMAXFONT = UIFont.systemFont(ofSize: 20)
let JDMINFONT = UIFont.systemFont(ofSize: 16)

func JDCOLOR (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
