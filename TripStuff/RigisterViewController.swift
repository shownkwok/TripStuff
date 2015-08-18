//
//  RigisterViewController.swift
//  TripStuff
//
//  Created by SHAWN on 8/1/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

class RigisterViewController: UIViewController ,UITextFieldDelegate{
    
    private let userInfo = NSMutableDictionary(contentsOfFile: userPath)

    struct constant {
        //animation constant
        static let InValidRigisterAnimationDuration: Double = 2
        static let InValidRigisterAnimationDelay: Double = 0
        static let InValidRigisterAnimationDamping: CGFloat = 0.4
        static let InValidRigisterAnimationInitialSpeed: CGFloat = 4
        
        static let RigisterSegueID = "Rigistered"
        static let InvalidRigister = "Invalid Info"
        static let InvalidUserName = "Invalid UserName"
        static let InvalidRigisterColor: UIColor = UIColor.redColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var username: UITextField!{
        didSet{
            username.delegate = self
        }
    }

    @IBOutlet weak var password: UITextField!{
        didSet{
            password.delegate = self
        }
    }

    @IBOutlet weak var reinputPassword: UITextField!{
        didSet{
            reinputPassword.delegate = self
        }
    }

    @IBOutlet weak var email: UITextField!{
        didSet{
            email.delegate = self
        }
    }

    
    @IBAction func rigister(sender: UIButton) {
        let originButtonColor = sender.backgroundColor
        let originButtonTitle = sender.titleLabel?.text
        if let i = userInfo{
            
            if username.text == "" || password.text == "" || reinputPassword.text == "" || password.text != reinputPassword.text {
                invalidInput(constant.InvalidRigister, button: sender, originTitle: originButtonTitle!, originColor: originButtonColor)
            }else{
                var ifUserNameUsed : Bool = false
                for users in i{
                    if username.text == String(users.key){
                        invalidInput(constant.InvalidUserName, button: sender, originTitle: originButtonTitle!, originColor: originButtonColor)
                        ifUserNameUsed = true
                    }
                }
                if ifUserNameUsed == false{
                        userInfo?.setValue(password.text, forKey: username.text!)
                        userInfo?.writeToFile(userPath, atomically: true)
                    
                        let newUserFile: NSMutableDictionary = NSMutableDictionary(contentsOfFile: "\(path)backup.plist")!
                        newUserFile.writeToFile("\(path)\(username.text!).plist", atomically: true)
                        performSegueWithIdentifier(constant.RigisterSegueID, sender: self)
                }
            }
        }
    }
    
    func invalidInput(info: String, button: UIButton, originTitle:String, originColor:UIColor?){
        button.backgroundColor = constant.InvalidRigisterColor
        button.setTitle(info, forState: UIControlState.Normal)
        button.center.x -= 10
        UIView.animateWithDuration(constant.InValidRigisterAnimationDuration, delay: constant.InValidRigisterAnimationDelay, usingSpringWithDamping: constant.InValidRigisterAnimationDamping, initialSpringVelocity: constant.InValidRigisterAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            button.center.x += 10
            }, completion: { (Bool) -> Void in
                button.setTitle(originTitle, forState: UIControlState.Normal)
                button.backgroundColor = originColor
        })
        password.text = ""
        reinputPassword.text = ""
    }

    @IBAction func cancel(sender: UIButton) {
    }
    

}
