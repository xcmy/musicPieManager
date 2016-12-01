//
//  JDSetAndAlterInfoVC.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/30.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit
import Alamofire

class JDSetAndAlterInfoVC: UIViewController,JDTextFViewDelegate {
    
    
    var controllerIdentifier:String?
    var scrollView:UIScrollView?
    var dataDic:[String:Any]? = nil
    
    
    var leftTitleArray:NSArray?
    var rightPlaceHolderArray:NSArray?
    var rightFormTypeArray:NSArray?
    var rightTextArray:NSArray?
    
    var saveBtn:UIButton? = nil
    var isAddVC:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        scrollView = UIScrollView()
        scrollView?.frame = JDRECT(xx: 0, yy: 0, w: JDWIDTH, h: JDHEIGHT)
        scrollView?.contentSize = CGSize(width:JDWIDTH,height:JDHEIGHT+200)
        scrollView?.isScrollEnabled = true
        self.view.addSubview(scrollView!)
        
        self.refreshData()
        
      
        // Do any additional setup after loading the view.
    }
    func refreshData(){
        
        if self.isAddVC! {
            self.dataDic = [:]
            self.refreshUI()
            
        }else{
            var  url:String? = nil
            var parms: Parameters? = nil
            switch controllerIdentifier! {
            case "organization":
                url = "/admin/ogranization/v1/getlist"
                parms = ["id":2]
            case "branch":
                url = "/admin/organizationBranch/v1/getlist"
                parms = ["id":9,"organizationid":2]
            case "administrator":
                url = "/admin/administrator/v1/getlist"
                parms = ["id":9]
            case "studentController":
                url = "/admin/studentController/v1/getlist"
                parms = ["id":6,"branchid":9]
            case "teacherController":
                url = "/admin/teacherController/v1/getlist"
                parms = ["id":2,"branchid":9]
            default: break
                
            }
            
            Alamofire.request("\(JDBASE_URL)\((url)!)", method: .get,parameters: parms).validate().responseJSON { (response ) in
                
                if response.result.isSuccess
                {
                    
                    
                    let  json = response.result.value as? NSDictionary
                    let array = json?.value(forKey: "data") as? NSArray
                    for (index,value) in (array?.enumerated())!{
                        if index == 0{
                            self.dataDic = value as? NSDictionary as! [String : Any]?
                        }
                    }
                    
                    print("\(json)")
                    self.refreshUI()
                    
                }else
                {
                    print("\(response.result.error)")
                    
                }
                
                
            }
        }
        
        
    }
    func updateData(){
    }
    func refreshUI(){
        let type_label  = JDTextFView.FORMTYPE.LABEL
        let type_text  = JDTextFView.FORMTYPE.TEXT
        let type_view  = JDTextFView.FORMTYPE.TEXTVIEW
        let type_list  = JDTextFView.FORMTYPE.LIST
        let type_image  = JDTextFView.FORMTYPE.IMAGE
        let type_select  = JDTextFView.FORMTYPE.SELECT
        let type_date  = JDTextFView.FORMTYPE.DATE
        
        
        switch controllerIdentifier! {
        case "organization":
            
            leftTitleArray = ["机构编码*：","机构名称：","机构法人：","电话号码：","机构介绍："]
            rightPlaceHolderArray = [""," 请输入机构名称"," 请输入机构法人"," 请输入电话号码"," 请输入机构介绍"]
            rightFormTypeArray = [type_label,type_text,type_text,type_text,type_view]
            rightTextArray = [toString(key: "organizationcode"),toString(key: "organizationname"),toString(key: "legalperson"),toString(key: "phonenumber"),toString(key: "introduction")]
            
        case "branch":
            
            leftTitleArray = ["分校名称：","分校电话：","分校地址：","分校介绍："]
            rightPlaceHolderArray = [" 请输入分校名称"," 请输入分校电话"," 请输入分校地址"," 请输入分校介绍"]
            rightFormTypeArray = [type_text,type_text,type_text,type_view]
            
            rightTextArray = [toString(key: "branchname"),toString(key: "branchphonenumber"),toString(key: "branchadress"),toString(key: "introduction")]
        case "administrator":
            
            leftTitleArray = ["账户名：","职业：","密码：","确认密码：","手机号码：","分校："]
            rightPlaceHolderArray = ["请输入账户名：","请输入职业：","请输入密码：","请输入确认密码：","请输入手机号码：","请输入分校："]
            rightFormTypeArray = [type_text,type_list,type_text,type_text,type_text,type_list]
            rightTextArray = [toString(key: "username"),"",toString(key: "password"),toString(key: "password"),toString(key: "phone"),""]
            
        case "studentController":
            
            leftTitleArray = ["学生姓名：","手机号：","密码：","确认密码：","头像：","性别：","生日：","家庭住址：","就读学校","家长姓名"]
            rightPlaceHolderArray = ["请输入学生姓名：","请输入手机号：","请输入密码：","请输入确认密码：","","","","请输入家庭住址：","请输入就读学校：","请输入家长姓名："]
            rightFormTypeArray = [type_text,type_text,type_text,type_text,type_image,type_select,type_date,type_text,type_text,type_text]
            rightTextArray = [toString(key: "studentname"),toString(key: "phonenumber"),toString(key: "password"),toString(key: "password"),"","","",toString(key: "studentaddress"),toString(key: "school"),toString(key: "parentname")]
            
        case "teacherController":
            
            leftTitleArray = ["老手姓名：","手机号：","密码：","确认密码：","毕业院校：","专业：","教龄：","教师等级：","头像：","性别：","类型："]
            rightPlaceHolderArray = ["请输入学生姓名：","请输入手机号：","请输入密码：","请输入毕业院校","请输入专业","请输入教龄","教师等级","请输入确认密码：","","",""]
            rightFormTypeArray = [type_text,type_text,type_text,type_text,type_text,type_text,type_text,type_text,type_image,type_select,type_text]
            rightTextArray = [toString(key: "teahername"),toString(key: "teacherphone"),toString(key: "password"),toString(key: "password"),toString(key: "graduated"),toString(key: "profession"),toString(key: "teachyear"),toString(key: "teacherlevel"),"","",""]
        
        default: break
            
        }
        
        var bottomTV :UIView?
        
        for (index,_) in (leftTitleArray?.enumerated())!{
            
            let tf = JDTextFView()
            tf.delegate = self
            tf.viewTag = index
            tf.frame = JDRECT(xx: 60, yy: CGFloat(70+70*index), w: 400, h: 50)
            tf.leftName = leftTitleArray?[index] as! String?
            tf.rightText = rightTextArray?[index] as!String?
            tf.placeholder = rightPlaceHolderArray?[index] as! String?
            tf.inputType = rightFormTypeArray?[index] as! JDTextFView.FORMTYPE?
            if tf.inputType == JDTextFView.FORMTYPE.TEXTVIEW{
                tf.frame = JDRECT(xx: 60, yy: CGFloat(70+70*index), w: 400, h: 150)
            }
            if tf.inputType == JDTextFView.FORMTYPE.LIST{
                tf.dataA = ["liu","de","li"]
            }
            if self.isAddVC! {
                tf.editStatus = true
            }else
            {
                tf.editStatus = false
            }
            tf.backgroundColor = UIColor.white
            scrollView!.addSubview(tf)
            
            
            if index == (leftTitleArray?.count)!-1 {
                bottomTV = tf
            }
        }
        
        self.saveBtn = UIButton()
        self.saveBtn?.frame = JDRECT(xx: (bottomTV?.left)!, yy: (bottomTV?.bottom)!+50, w: (bottomTV?.width)!, h: 50)
        self.saveBtn?.setTitle("保存", for: UIControlState.normal)
    
        self.saveBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.saveBtn?.backgroundColor = UIColor.darkGray
        scrollView?.addSubview(self.saveBtn!)
        
        
        let alterBtn = UIButton()
        alterBtn.frame = JDRECT(xx: ((bottomTV?.right)!+60), yy: 70, w: 100, h: 50)
        alterBtn.setTitle("编辑", for: UIControlState.normal)
        alterBtn.setTitle("取消编辑", for: UIControlState.selected)
        alterBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        alterBtn.backgroundColor = UIColor.darkGray
        alterBtn.addTarget(self, action: #selector(alterBtnClick(_:)), for: UIControlEvents.touchUpInside)
        scrollView?.addSubview(alterBtn)
        
        if self.isAddVC! {
            alterBtn.isHidden = true
            self.saveBtn?.isHidden = false
            self.saveBtn?.setTitle("添加", for: UIControlState.normal)
            self.saveBtn?.addTarget(self, action: #selector(addBtnClick(_:)), for: UIControlEvents.touchUpInside)
        }else
        {
            self.saveBtn?.isHidden = true
            self.saveBtn?.addTarget(self, action: #selector(saveBtnClick(_:)), for: UIControlEvents.touchUpInside)
        }
        
        
    }
    
   
    func alterBtnClick(_ button:UIButton)  {
        if button.isSelected {
            
            self.changEditStatus(status: false)
            self.saveBtn?.isHidden = true
            button.isSelected = false
        }else
        {
            self.changEditStatus(status: true)
            self.saveBtn?.isHidden = false
            button.isSelected = true
        }
        
    }
    
    func saveBtnClick(_ button:UIButton)  {
        var  url:String? = nil
        var parms: Parameters? = nil
        switch controllerIdentifier! {
        case "organization":
            url = "/admin/ogranization/v1/update"
            parms = self.dataDic
            parms?["id"] = 2
        case "branch":
            url = "/admin/organizationBranch/v1/update"
            parms = self.dataDic
            parms?["id"] = 9
        case "administrator":
            url = "/admin/administrator/v1/update"
            parms = self.dataDic
            parms?["id"] = 9
        case "studentController":
            url = "/admin/studentController/v1/update"
            parms = self.dataDic
            parms?["id"] = 2
        case "teacherController":
            url = "/admin/teacherController/v1/update"
            parms = self.dataDic
            parms?["id"] = 10
        case "course":
            url = "/admin/course/v1/update"
            parms = self.dataDic
            parms?["id"] = 2
        
        default: break
            
        }
        print("\(parms!)")
        Alamofire.request("\(JDBASE_URL)\((url)!)", method: .put,parameters: parms!).validate().responseJSON { (response ) in
            
            if response.result.isSuccess
            {
                print("\(response.result.value)")
            }else
            {
                print("\(response.debugDescription)")
                
            }
            
            
        }
        
        
    }
    
    
    
    func toString(key:String) -> String {
        
        if (self.dataDic == nil)||(self.dataDic?.isEmpty)! {
            return ""
        }
        return  String(describing: (self.dataDic![key]!))
    }

    
    func addBtnClick(_ button:UIButton)  {
    
        
        var  url:String? = nil
        var parms: Parameters? = nil
        switch controllerIdentifier! {
        case "branch":
            url = "/admin/organizationBranch/v1/add"
            parms = self.dataDic!
            parms?["organizationid"] = 2
        case "administrator":
            url = "/admin/administrator/v1/add"
            parms = self.dataDic
            parms?["organizationbranchid"] = 9
        case "studentController":
            url = "/admin/studentController/v1/add"
            parms = self.dataDic
            parms?["branchId"] = 9
        case "teacherController":
            url = "/admin/teacherController/v1/add"
            parms = self.dataDic
            parms?["branchid"] = 9
        case "course":
            url = "/admin/course/v1/add"
            parms = self.dataDic
            parms?["branchid"] = 9
        default: break
            
        }
        print("parms:\(parms!)")
        
        Alamofire.request("\(JDBASE_URL)\((url)!)", method: .post,parameters: parms!).validate().responseJSON { (response ) in
            
            if response.result.isSuccess
            {
                print("\(response.result.value)")
            }else
            {
                print("\(response.debugDescription)")
                
            }
            
            
        }

    }
    func changEditStatus(status:Bool) {
        
        for view in (scrollView?.subviews)! {
            if view is JDTextFView {
                for subView in view.subviews {
                    if subView is UITextField {
                        (subView as! UITextField).isEnabled = status
                    }
                    if subView is UITextView {
                        (subView as! UITextView).isEditable = status
                    }
                    
                }
            }
            
        }

        
    }
    
    func getDataFromForm(viewtag: Int, dataString: String) {
        
        print("\(dataString)++\(viewtag)")
        
        switch controllerIdentifier! {
        case "organization":
            switch viewtag {
            case 1:
                self.dataDic?["organizationname"]  = dataString
            case 2:
                self.dataDic?["legalperson"] = dataString
            case 3:
                self.dataDic?["phonenumber"] = dataString
            case 4:
                self.dataDic?["introduction"] = dataString
            default: break
                
            }
        case "branch":
            switch viewtag {
            case 0:
                self.dataDic?["branchname"] = dataString
            case 1:
                self.dataDic?["branchphonenumber"]  = dataString
            case 2:
                self.dataDic?["branchadress"] = dataString
            case 3:
                self.dataDic?["introduction"] = dataString
                
            default: break
                
            }
        case "administrator":
            switch viewtag {
            case 0:
                self.dataDic?["username"] = dataString
            case 1:
                self.dataDic?["type"] = 1
            case 2:
                self.dataDic?["password"] = dataString
            case 4:
                self.dataDic?["phone"]  = dataString
                
            default: break
                
            }
        default: break
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
