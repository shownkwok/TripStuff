//
//  LoginViewController.swift
//  TripStuff
//
//  Created by SHAWN on 7/31/15.
//  Copyright © 2015 SHAWN. All rights reserved.
//

import UIKit

//overall constant



class LoginViewController: UIViewController, UITextFieldDelegate {
    private let userInfo = NSMutableDictionary(contentsOfFile: userPath)

    struct constant {
        //animation constant
        static let LogoAnimationDuration: Double = 2
        static let LogoAnimationDelay: Double = 0.2
        static let LogoAnimationDamping: CGFloat = 0.5
        static let LogoAnimationInitialSpeed: CGFloat = 5
        static let InValidLoginAnimationDuration: Double = 2
        static let InValidLoginAnimationDelay: Double = 0
        static let InValidLoginAnimationDamping: CGFloat = 0.4
        static let InValidLoginAnimationInitialSpeed: CGFloat = 4
        static let LoginSegueID = "Login"
        static let RigisterSegueID = "Rigister"
        static let InvalidLoginColor: UIColor = UIColor.redColor()
        static let InvalidLogin = "Invalid Info"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var logo1: UIImageView!
    @IBOutlet weak var logo2: UIImageView!
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
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var rigisterOutlet: UIButton!
    @IBAction func login(sender: UIButton) {
        let originButtonTitle = sender.titleLabel?.text
        let originButtonColor = sender.backgroundColor
        if let i = userInfo{
            var isUserInfoCorrect = false
            for users in i{
                if username.text == String(users.key) && password.text == String(users.value){
                    user = username.text!
                    performSegueWithIdentifier(constant.LoginSegueID, sender: self)
                    isUserInfoCorrect = true
                }
            }
            if isUserInfoCorrect == false{
                sender.backgroundColor = constant.InvalidLoginColor
                sender.setTitle(constant.InvalidLogin, forState: UIControlState.Normal)
                sender.center.x -= 20
                UIView.animateWithDuration(constant.InValidLoginAnimationDuration, delay: constant.InValidLoginAnimationDelay, usingSpringWithDamping: constant.InValidLoginAnimationDamping, initialSpringVelocity: constant.InValidLoginAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    sender.center.x += 20
                    }, completion: { (Bool) -> Void in
                        sender.setTitle(originButtonTitle, forState: UIControlState.Normal)
                        sender.backgroundColor = originButtonColor
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo1.alpha = 0
        self.logo2.center.x -= UIScreen.mainScreen().bounds.width
        UIView.animateWithDuration(constant.LogoAnimationDuration, delay: constant.LogoAnimationDelay, usingSpringWithDamping: constant.LogoAnimationDamping, initialSpringVelocity: constant.LogoAnimationInitialSpeed, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.logo2.center.x += UIScreen.mainScreen().bounds.width
            self.logo1.alpha = 1
            }, completion: nil)
    }
    
    @IBAction func rigister(sender: UIButton) {
        performSegueWithIdentifier(constant.RigisterSegueID, sender: self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
    }
}
