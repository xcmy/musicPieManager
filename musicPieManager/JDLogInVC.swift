//
//  JDLogInVC.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/24.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit

class JDLogInVC: UIViewController {

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let bgImageV = UIImageView()
        bgImageV.frame = CGRect(x:0,y:0,width:JDWIDTH,height:JDHEIGHT)
        bgImageV.image = UIImage(named:"bg.png")
        self.view.addSubview(bgImageV)
        
        
        let whiteView = UIView()
        whiteView.bounds = JDRECT(xx: 0, yy: 0, w: JDWIDTH/2.5, h: 380)
        whiteView.center = self.view.center
        whiteView.backgroundColor = JDCOLOR(hex: "#EBF0F1")
        whiteView.layer.cornerRadius = 5
        self.view.addSubview(whiteView)
        
        
        
        let formViewOne = JDFormView()
        formViewOne.frame = CGRect(x: 50, y: 40, width: JDWIDTH/2.5-100, height: 50)
        formViewOne.backgroundColor = UIColor.white
        formViewOne.layer.borderColor = JDCOLOR(hex: "#D0D4D9").cgColor
        formViewOne.leftName = "账号:"
        whiteView.addSubview(formViewOne)
        
        
        let formView2 = JDFormView()
        formView2.frame = CGRect(x: 50, y: 30+formViewOne.bottom, width: JDWIDTH/2.5-100, height: 50)
        formView2.backgroundColor = UIColor.white
        formView2.leftName = "密码:"
        whiteView.addSubview(formView2)
        
    
        let formView3 = JDFormView()
        formView3.frame = CGRect(x: 50, y: 30+formView2.bottom, width: JDWIDTH/2.5-100, height: 50)
        formView3.backgroundColor = UIColor.white
        formView3.leftName = "机构编码:"
        whiteView.addSubview(formView3)
        
        
        
        
        let sumbitBtn = UIButton()
        sumbitBtn.frame = CGRect(x:formViewOne.left,y:formView3.bottom+40,width:formViewOne.width,height:formViewOne.height)
        sumbitBtn.setTitle("登录",for:UIControlState.normal)
        sumbitBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        sumbitBtn.backgroundColor = JDCOLOR(hex: "#6CBFCC")
        sumbitBtn.addTarget(self, action:#selector(buttonClick(_:)), for: UIControlEvents.touchUpInside)
        whiteView.addSubview(sumbitBtn)
        
        // Do any additional setup after loading the view.
        
    }
    
    func buttonClick(_ button:UIButton)   {
       print("haha")
        self.navigationController?.pushViewController(JDMainVC(), animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
