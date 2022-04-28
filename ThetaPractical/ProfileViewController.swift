//
//  ProfileViewController.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var btnLogout: UIButton! {
        didSet {
            self.btnLogout.setTitle("Logout", for: .normal)
        }
    }
    @IBOutlet weak var lblEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserDefaults.standard.value(forKey: "logindata") as? [String: Any], let email = user["email"] as? String {
            self.lblEmail.text = email
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapBtnLogout(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            UIApplication.shared.keyWindow?.windowScene?.windows.first?.rootViewController = vC
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
