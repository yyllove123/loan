//
//  LoginViewController.swift
//  GaiJu
//
//  Created by Yalin on 2017/8/29.
//  Copyright © 2017年 yyl. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgetPwdButton: UIButton!
    @IBOutlet weak var secureButton: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginViewYCenterConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    deinit {
        // perform the deinitialization
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "用户登录"
        
        let keyboardShowSelector: Selector = #selector(LoginViewController.keyboardShow)
        let keyboardHideSelector: Selector = #selector(LoginViewController.keyboardHide)
        NotificationCenter.default.addObserver(self, selector: keyboardShowSelector, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: keyboardHideSelector, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        loginButton.setDefaultStyle()
        
        usernameTextField.setDefaultStyle()
        passwordTextField.setDefaultStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method Response
    @IBAction func loginButtonPressed(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        AppDelegate.applicationDelegate().updateHUD(HUDType.hotwheels, message: "正在登录", detailMsg: nil, progress: nil)
        LoginManager.login(self.usernameTextField.text, password: passwordTextField.text, autoLogin: false) { [unowned self] (error: NSError?) in
            
            AppDelegate.applicationDelegate().hiddenHUD()
            
            if error == nil {
                
                self.cancelItemPressed()
            }
            else {
                Alert.showErrorAlert("登录失败", message: error!.localizedDescription)
            }
        }
        
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @IBAction func forgetPwdButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(ForgetPwdViewController(), animated: true)
    }
    
    @IBAction func cancelItemPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bgButtonPressed(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func secureButtonPressed(_ sender: Any) {
        secureButton.isSelected = !secureButton.isSelected
        
        passwordTextField.isSecureTextEntry = !secureButton.isSelected
    }
    // MARK: - KeyboardNotification
    func keyboardShow() {
        if !self.usernameTextField.isFirstResponder && !self.passwordTextField.isFirstResponder {
            return
        }
        loginViewYCenterConstraint.constant = CGFloat(loginView.frame.size.height - UIScreen.main.bounds.size.height) / 2
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardHide() {
        if !self.usernameTextField.isFirstResponder && !self.passwordTextField.isFirstResponder {
            return
        }
        
        loginViewYCenterConstraint.constant = 0
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] () -> Void in
            self.view.layoutIfNeeded()
        })
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
