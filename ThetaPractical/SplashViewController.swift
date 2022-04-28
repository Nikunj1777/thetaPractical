//
//  SplashViewController.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Bool, isLogin {
            if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
                let nav = UINavigationController(rootViewController: vC)
                UIApplication.shared.keyWindow?.windowScene?.windows.first?.rootViewController = nav
            }
        } else {
            if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                UIApplication.shared.keyWindow?.windowScene?.windows.first?.rootViewController = vC
            }
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
