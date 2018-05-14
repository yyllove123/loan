//
//  ForgetPwdViewController.swift
//  GaiJu
//
//  Created by gaowei on 2017/8/31.
//  Copyright © 2017年 yyl. All rights reserved.
//

import UIKit

class ForgetPwdViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var captchaTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var passwordSecureButton: UIButton!
    @IBOutlet weak var confirmPwdSecureButton: UIButton!
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var centerViewYCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var queryCaptchaButton: UIButton!
    var reQueryCaptchas: Timer?
    var requeryCaptchasTimerCount: Int8 = 0
    
    // MARK: - Life Cycle
    deinit {
        // perform the deinitialization
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "找回密码"
//        ForgetPwdViewController.keybo
        let keyboardShowSelector: Selector = #selector(ForgetPwdViewController.keyboardShow)
        let keyboardHideSelector: Selector = #selector(ForgetPwdViewController.keyboardHide)
        NotificationCenter.default.addObserver(self, selector: keyboardShowSelector, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: keyboardHideSelector, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        confirmButton.setDefaultStyle()
        
        phoneTextField.setDefaultStyle()
        passwordTextField.setDefaultStyle()
        confirmPasswordTextField.setDefaultStyle()
        captchaTextField.setDefaultStyle()
        
        queryCaptchaButton.layer.borderColor = greenButtonColor.cgColor
        queryCaptchaButton.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserData.sharedInstance.phone != nil {
            phoneTextField.text = UserData.sharedInstance.phone
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Response
    @IBAction func bgButtonPressed(_ sender: Any) {
        for view in centerView.subviews {
            if let textField = view as? UITextField {
                textField.resignFirstResponder()
            }
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        
        if passwordTextField.text == nil {
            Alert.showErrorAlert("注册失败", message: "请填写密码")
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            Alert.showErrorAlert("注册失败", message: "两次密码输入不一致")
            return
        }
        
        self.updateHUD(HUDType.hotwheels, message: "正在提交", detailMsg: nil, progress: nil)
        
        LoginManager.findForgetPwd([
            "phone": phoneTextField.text ?? "",
            "captcha": captchaTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]) { (error) in
            self.hiddenHUD()
            if error == nil {
                
                self.navigationController?.popViewController(animated: true)
            }
            else {
                Alert.showErrorAlert(nil, message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func passwordSecureButtonPressed(_ sender: Any) {
        passwordSecureButton.isSelected = !passwordSecureButton.isSelected
        passwordTextField.isSecureTextEntry = !passwordSecureButton.isSelected
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmPwdSecureButtonPressed(_ sender: Any) {
        confirmPwdSecureButton.isSelected = !confirmPwdSecureButton.isSelected
        confirmPasswordTextField.isSecureTextEntry = !confirmPwdSecureButton.isSelected
    }
    
    // MARK: - Captcha Method
    @IBAction func reQueryCaptchas(_ sender: AnyObject) {
        queryCaptchaButton.isEnabled = false
        requeryCaptchasTimerCount = 0
        reQueryCaptchas = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegisterViewController.requeryCaptchasTimer), userInfo: nil, repeats: true)
        
        self.updateHUD(HUDType.hotwheels, message: "获取验证码", detailMsg: nil, progress: nil)
        LoginManager.queryCaptchas(self.phoneTextField.text, type: 2) {[unowned self] (captcha, error: NSError?) -> Void in
            if error != nil {
                Alert.showErrorAlert("获取验证码失败", message: error?.localizedDescription)
                self.queryCaptchaButton.isEnabled = true
                self.reQueryCaptchas?.invalidate()
                self.queryCaptchaButton.setTitle("发送验证码", for: UIControlState())
            }
            self.hiddenHUD()
        }
    }
    
    func requeryCaptchasTimer() {
        
        let maxRequeryCount: Int8 = 60
        requeryCaptchasTimerCount += 1
        queryCaptchaButton.setTitle("\(maxRequeryCount - requeryCaptchasTimerCount)秒", for: UIControlState())
        
        if requeryCaptchasTimerCount >= maxRequeryCount {
            queryCaptchaButton.isEnabled = true
            reQueryCaptchas?.invalidate()
            queryCaptchaButton.setTitle("发送验证码", for: UIControlState())
        }
    }
    
    // MARK: - KeyboardNotification
    
    func firstResponder() -> UITextField? {
        for view in centerView.subviews {
            if let textField = view as? UITextField {
                
                if textField.isFirstResponder {
                    return textField
                }
            }
        }
        
        return nil
    }
    
    @objc func keyboardShow() {
        
        guard let textField = firstResponder() else {
            return
        }
        
        centerViewYCenterConstraint.constant = CGFloat(centerView.frame.size.height - UIScreen.main.bounds.size.height) / 2 - (textField.frame.origin.y - 30 - textField.frame.size.height)
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardHide() {
        guard let _ = firstResponder() else {
            return
        }
        
        centerViewYCenterConstraint.constant = 0
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
