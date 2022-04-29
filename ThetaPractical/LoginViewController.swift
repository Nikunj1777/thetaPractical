//
//  LoginViewController.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    
    // MARK: - Oulet and variables
    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            self.txtEmail.setRoundCorner()
            self.txtEmail.setBorder()
            self.txtEmail.setPadding(left: 10, right: 10)
            self.txtEmail.delegate = self
        }
    }
    @IBOutlet weak var txtPass: UITextField! {
        didSet {
            self.txtPass.setRoundCorner()
            self.txtPass.setBorder()
            self.txtPass.setPadding(left: 10, right: 10)
            self.txtPass.isSecureTextEntry = true
            self.txtEmail.delegate = self
        }
    }
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            self.btnLogin.layer.cornerRadius = self.btnLogin.frame.size.height/2
            self.btnLogin.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var btnShowPass: UIButton! {
        didSet {
            self.btnShowPass.setTitle("", for: .normal)
            self.btnShowPass.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    @IBOutlet weak var btnSignUp: UIButton!
    var isClickShow = false

    // MARK: - Viewlifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction method
    @IBAction func didTapBtnShowPass(_ sender: UIButton) {
        self.isClickShow = !self.isClickShow
        self.btnShowPass.setImage( self.isClickShow ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill"), for: .normal)
        self.txtPass.isSecureTextEntry = self.isClickShow ? false : true
    }
    
    @IBAction func didTapBtnLogin(_ sender: UIButton) {
        if let user = UserDefaults.standard.value(forKey: "logindata") as? [String: Any], let email = user["email"] as? String, let pass = user["pass"] as? String {
            if email == txtEmail.text, pass == txtPass.text {
                // Move to home screen with tab bar
                print("Login Successfully")
                UserDefaults.standard.set(true, forKey: "isLogin")
                if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
                    let nav = UINavigationController(rootViewController: vC)
                    UIApplication.shared.keyWindow?.windowScene?.windows.first?.rootViewController = nav
                    return
                }
            } else {
                Common.showAlert(title: "Oops", message: "Invalid email and password.")
            }
        }
    }
}

// MARK: - Textfield delegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let strTotal: Int = (textField.text!+string).count
        if range == NSRange(location: 0, length: 0) {
            if string == " " {
                return false
            }
        }
        if (textField.text!+string).containsEmoji == true {
            return false
        }
        let langStr = Locale.current.languageCode
        if langStr! == "ar" {
            return true
        }
        if strTotal > 64 && string != "" {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text != "", let isValid = text.ValidateEmail() as? Bool, !isValid {
            Common.showAlert(title: "Invalid Email", message: "Please entear a valid email.")
        }
    }
}


