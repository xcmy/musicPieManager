//
//  JDTextFView.swift
//  musicPieManager
//
//  Created by 刘洋 on 2016/11/28.
//  Copyright © 2016年 jdzw. All rights reserved.
//

import UIKit
import ReactiveCocoa


protocol JDTextFViewDelegate : NSObjectProtocol{
    func getDataFromForm(viewtag:Int,dataString:String)
    
}

class JDTextFView: UIView,UITableViewDelegate,UITableViewDataSource {
    
   
    enum FORMTYPE {
        case TEXT;
        case TEXTVIEW;
        case SELECT;
        case DATE;
        case LIST;
        case LABEL;
        case IMAGE
    }
    
    weak var delegate:JDTextFViewDelegate?
    
    var leftName : String?
    var rightText : String? = nil
    var placeholder : String?
    var inputType:FORMTYPE?
    var tableView:UITableView?
    var dataA:NSArray?
    var viewTag:Int?
    
    var editStatus:Bool?
    
    var lastBtn:UIButton?
    var genderLastBtn:UIButton?
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        let leftl = UILabel()
        leftl.frame = CGRect(x:0,y:0,width:rect.size.width*0.27,height:50)
        leftl.textColor = UIColor.darkGray
        leftl.text=leftName
        leftl.textAlignment = NSTextAlignment.right
        leftl.font = JDSTANDFONT
        self.addSubview(leftl)
        
        if self.inputType == .LABEL {
            let tf = UILabel()
            tf.frame = CGRect(x:leftl.right+rect.size.width*0.02,y:5,width:rect.size.width*0.71,height:40)
            tf.text = rightText
            tf.textColor = UIColor.gray
            tf.layer.borderColor = JDBORDERCOLOR
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = 3
            tf.font = JDSTANDFONT
            tf.clipsToBounds = true
            self.addSubview(tf)
            
        }
        
        
        if self.inputType == .TEXT {
            let tf = UITextField()
            tf.frame = CGRect(x:leftl.right+rect.size.width*0.02,y:5,width:rect.size.width*0.71,height:40)
            tf.placeholder = placeholder
            tf.text = rightText
            tf.layer.borderColor = JDBORDERCOLOR
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = 3
            tf.font = JDSTANDFONT
            tf.clipsToBounds = true
            tf.isEnabled = editStatus!
            self.addSubview(tf)
            
            _ = tf.reactive.continuousTextValues.observeResult({ (result) in
                
                self.delegate?.getDataFromForm(viewtag: self.viewTag!, dataString:"\(result.value!!)" )
            })
        }
        
        if self.inputType == .TEXTVIEW {
            let textView = UITextView()
            textView.frame = CGRect(x:leftl.right+rect.size.width*0.02,y:5,width:rect.size.width*0.71,height:150)
            textView.layer.borderColor = JDBORDERCOLOR
            textView.layer.borderWidth = 1
            textView.layer.cornerRadius = 3
            textView.font = JDSTANDFONT
            textView.text=rightText
            textView.clipsToBounds = true
            textView.isEditable = editStatus!
            self.addSubview( textView)
            
            let placeH = UILabel()
            placeH.frame = JDRECT(xx: 5, yy: 5, w: ( textView.width)-10, h: 30)
            placeH.text = placeholder
            placeH.font = JDSTANDFONT
            placeH.textColor = UIColor.lightGray
            placeH.textAlignment = NSTextAlignment.left
            textView.addSubview(placeH)
            
            
            if (rightText?.characters.count)! > 0 {
                placeH.isHidden = true
            }
            
            _ =  textView.reactive.continuousTextValues.observeResult({ (result) in
                
                
                self.delegate?.getDataFromForm(viewtag: self.viewTag!, dataString:"\(result.value!)" )
                
                if ((textView.text.characters.count) > 0) {
                    placeH.isHidden = true
                }else
                {
                    placeH.isHidden = false
                }
            })

        }
        
        if self.inputType == .LIST {
            
            let button  = UIButton()
            button.frame = CGRect(x:leftl.right+rect.size.width*0.02,y:5,width:rect.size.width*0.4,height:40)
            button.layer.cornerRadius = 3
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 1
            button.setTitle(placeholder, for: UIControlState.normal)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            button.titleLabel?.font = JDSTANDFONT
            button.addTarget(self, action: #selector(buttonClick(_:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
            
            
            let imageV = UIImageView()
            imageV.frame = JDRECT(xx: button.width-20, yy: 10, w: 10, h: 20)
            imageV.image = UIImage(named:"select")
            button.addSubview(imageV)
            
            
        
            self.tableView = UITableView(frame:JDRECT(xx: self.frame.origin.x+rect.size.width*0.02+leftl.right, yy: self.frame.origin.y+47, w: rect.size.width*0.4, h: 200),style:UITableViewStyle.plain)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.layer.borderColor = UIColor.gray.cgColor
            self.tableView?.layer.borderWidth = 1
            self.tableView?.layer.cornerRadius=3
            self.tableView?.isScrollEnabled = true
            self.tableView?.isHidden = true
            self.tableView?.separatorColor = UIColor.white
            self.tableView?.backgroundColor = UIColor.white
            button.superview?.superview?.addSubview(tableView!)
            
            
            
        
        }
        
         if self.inputType == .SELECT {
            
            let genderA = ["女","男"]
            for  i in 0..<2 {
                let genderBtn = UIButton(frame:JDRECT(xx: leftl.right+CGFloat(150*i), yy: 5, w: 100, h: 40))
                genderBtn.setTitle(genderA[i], for: UIControlState.normal)
                genderBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
                genderBtn.setTitleColor(UIColor.white, for: UIControlState.selected)
                if i == 0 {
                    genderBtn.isSelected = true
                    genderBtn.backgroundColor = UIColor.darkGray
                    self.genderLastBtn = genderBtn
                }else
                {
                    genderBtn.isSelected = false
                    genderBtn.backgroundColor = UIColor.white
                }
                genderBtn.addTarget(self, action: #selector(genderBtnClick(_:)), for: UIControlEvents.touchUpInside)
                self.addSubview(genderBtn)
                
            }
        }
         if self.inputType == .IMAGE {
            
            let headIV = UIImageView(frame:JDRECT(xx: leftl.right, yy: 0, w: 50, h: 50))
            headIV.image = UIImage(named:"alter")
            self.addSubview(headIV)
            
            let uploadBtn = UIButton(frame:JDRECT(xx: headIV.right, yy: 5, w: self.width-headIV.right, h: 40))
            uploadBtn.setTitle("上传", for: UIControlState.normal)
            uploadBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
            uploadBtn.backgroundColor = UIColor.gray
            self.addSubview(uploadBtn)
            
        }
        self.backgroundColor  = UIColor.white
        
    }
    
    func genderBtnClick(_ button:UIButton) ->  Void {
        
        if genderLastBtn == button {
            return
        }
        genderLastBtn?.backgroundColor = UIColor.white
        genderLastBtn?.isSelected = false
        button.backgroundColor = UIColor.darkGray
        button.isSelected = true

        genderLastBtn = button

    }
    
    func buttonClick(_ button:UIButton) ->  Void {
        
        self.lastBtn = button
        if button.isSelected {
            self.tableView?.isHidden = true
             button.isSelected = false
        }else
        {
            self.tableView?.isHidden = false
            button.isSelected = true

        }
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataA?[indexPath.row] as! String?
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.separatorInset = UIEdgeInsets.zero
        return cell
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataA?.count)!
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.getDataFromForm(viewtag: self.viewTag!, dataString:"\(indexPath.row)===" )
        self.tableView?.isHidden = true
        self.lastBtn?.isSelected = false
    }

}
