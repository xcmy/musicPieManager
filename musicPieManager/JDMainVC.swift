//
//  JDMainVC.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/24.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit
import Foundation

class JDMainVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tableView:UITableView? = nil
    var leftWidth:CGFloat = 150
    
    var numberA = [4,0,0,0,0,0,0,0]
    var lastButton:UIButton? = nil
    
    
    var mainNav:UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        let gradView = JDGradualView()
        gradView.frame = JDRECT(xx: 0, yy: 0, w: leftWidth, h: JDHEIGHT)
        gradView.endPoint = CGPoint(x:1,y:1)
        self.view.addSubview(gradView)
        
        self.tableView = UITableView(frame: JDRECT(xx: 0, yy: 64, w: leftWidth, h: JDHEIGHT-64) ,style: UITableViewStyle.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.separatorColor = UIColor.clear
        self.tableView!.backgroundColor = UIColor.clear
        self.tableView!.rowHeight = 40
        self.view.addSubview(self.tableView!)

        
        
        let topView = UIView(frame:JDRECT(xx: 0, yy: 0, w: JDWIDTH, h: 64))
        topView.backgroundColor = JDCOLOR(hex: "#3D454F")
        UIApplication.shared.delegate?.window??.addSubview(topView)
        
        let menuTopBtn  = UIButton()
        menuTopBtn.frame = JDRECT(xx: 120, yy: 0, w: 30, h: 64)
        menuTopBtn.setBackgroundImage(UIImage(named:"menuBtn"), for: UIControlState.normal)
        menuTopBtn.addTarget(self, action: #selector(menuBtnClick(_:)), for: UIControlEvents.touchUpInside)
        topView.addSubview(menuTopBtn)
        
        

        let backBtn  = UIButton()
        backBtn.frame = JDRECT(xx: menuTopBtn.right+50, yy: 17, w: 28, h: 36)
        backBtn.setBackgroundImage(UIImage(named:"backBtn"), for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(_:)), for: UIControlEvents.touchUpInside)
        topView.addSubview(backBtn)
        
        
        let topLabel = UILabel(frame:JDRECT(xx: leftWidth, yy: 0, w: JDWIDTH-leftWidth, h: 64))
        topLabel.text = "主页"
        topLabel.textColor = UIColor.white
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.systemFont(ofSize: 18)
        topView.addSubview(topLabel)
        
                
        
        let orgVC = JDSetAndAlterInfoVC()
        orgVC.controllerIdentifier = "organization"
        orgVC.isAddVC = false
        mainNav = UINavigationController(rootViewController:orgVC)
        mainNav?.navigationBar.isHidden = true
        self.addChildViewController(mainNav!)
        mainNav!.view.frame = JDRECT(xx: leftWidth, yy: 0, w: JDWIDTH-leftWidth, h: JDHEIGHT)
        self.view.addSubview(mainNav!.view)
        
        
    }
    func backBtnClick(_ button:UIButton)  {
        _ = mainNav?.popViewController(animated: false)
    }
    func menuBtnClick(_ button:UIButton)  {
        
        if button.isSelected {
            UIView.animate(withDuration: 0.5, animations: {
                self.mainNav?.view.frame = JDRECT(xx: self.leftWidth, yy: 0, w: JDWIDTH-self.leftWidth, h: JDHEIGHT)
            }, completion: {(finished) in
            })
            button.isSelected = false
        }else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.mainNav?.view.frame = JDRECT(xx: 0, yy: 0, w: JDWIDTH, h: JDHEIGHT)
            }, completion: {(finished) in
            })
            button.isSelected = true
        }
        
    }
    func sectionTopBtnClick(_ button:UIButton)  {
        
        let array = [4,3,2,1,5,1,2,2]
        
        if numberA[button.tag]>0 {
            button.isSelected = true
            numberA[button.tag] = 0
            button.isSelected = false
        }else
        {
            button.isSelected = false
            numberA[button.tag] = array[button.tag]
            button.isSelected = true
        }

        if button.isSelected == true {
            
        }else
        {
            
        }
        lastButton = button
        tableView?.reloadData()
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberA[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let topView = UIView()
        topView.frame = JDRECT(xx: 0, yy: 0, w: leftWidth, h: 50)
        
        let titleA = [" 教务管理"," 用户管理"," 教师管理"," 课程管理"," APP设置"," 财务管理"," 系统管理"," 机构管理"]
        let imageA = ["menu1","menu2","menu3","menu4","menu5","menu6","menu7","menu8"]
        
        let shape = UIImageView(frame:JDRECT(xx: 0, yy: 0, w: 20, h: 18))
        shape.image = UIImage(named:imageA[section])
        
        let title = UITextField(frame:JDRECT(xx: 10, yy: 0, w: leftWidth-10, h: 50))
        title.leftView = shape
        title.leftViewMode = UITextFieldViewMode.always
        title.isEnabled = false
        title.text = titleA[section]
        title.textColor = UIColor.white
        title.textAlignment = NSTextAlignment.left
        title.font = JDSTANDFONT
        topView.addSubview(title)
        
        
        let sectionTopBtn  = UIButton()
        sectionTopBtn.frame = JDRECT(xx: 0, yy: 0, w: leftWidth, h: 50)
        sectionTopBtn.addTarget(self, action: #selector(sectionTopBtnClick(_:)), for: UIControlEvents.touchUpInside)
        if section == lastButton?.tag {
            sectionTopBtn.isSelected = (lastButton?.isSelected)!
        }
        sectionTopBtn.tag  = section
        topView.addSubview(sectionTopBtn)
        
        
        return topView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let nameA = [["今日课堂","排课管理","作业管理","学员评价"],["添加学员","学员档案","用户管理"],["添加教师","教室档案"],["课程管理"],["APP首页","APP动态","教室管理","琴行广告","用户反馈"],["财务管理"],["账号管理","个人中心"],["机构设置","分校设置"]]
        
        
        let cell = JDMenuCell()
        cell.backgroundColor = UIColor.clear
        cell.subLabel?.text = nameA[indexPath.section][indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = JDSetAndAlterInfoVC()
        
        if indexPath.section==7&&indexPath.row==0 {
            pushVC.controllerIdentifier = "organization"
            pushVC.isAddVC = false
        }
        
        if indexPath.section==7&&indexPath.row==1 {
            pushVC.controllerIdentifier = "branch"
            pushVC.isAddVC = false
        }
        if indexPath.section==6&&indexPath.row==1 {
            pushVC.controllerIdentifier = "branch"
            pushVC.isAddVC = true
        }
        if indexPath.section==6&&indexPath.row==0 {
            pushVC.controllerIdentifier = "administrator"
            pushVC.isAddVC = false
        }
        if indexPath.section==1&&indexPath.row==0 {
            pushVC.controllerIdentifier = "studentController"
            pushVC.isAddVC = false
        }
        if indexPath.section==2&&indexPath.row==0 {
            pushVC.controllerIdentifier = "teacherController"
            pushVC.isAddVC = false
        }
        if indexPath.section==3&&indexPath.row==0 {
            pushVC.controllerIdentifier = "course"
            pushVC.isAddVC = false
        }
        
        
        mainNav?.pushViewController(pushVC, animated: true)

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
