//
//  CommonFunction.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class Common {
    // MARK: - Alert declaration
    class func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        appDelegate.rootViewController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Set image from string url
    class func setImageFromString(imgString: String) -> UIImage {
        if let url = URL(string: imgString), let data = try? Data(contentsOf: url) as? Data, let img = UIImage(data: data) {
            return img
        } else {
            return UIImage()
        }
    }
    
    class func delay(delay: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(Double(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    
}

// MARK: - Extension Appdelegate
extension AppDelegate {
    func rootViewController() -> UIViewController {
        return appDelegate.window?.rootViewController ?? UIViewController()
    }
}

// MARK: - Extension UIView
extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.9).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 15)
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 30
    }
}

// MARK: - Extension String
extension String {
    func ValidateEmail() -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,8}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        if emailTest.evaluate(with: self.trimsString()) != true {
            return false
        } else {
            return true
        }
    }
    
    func trimsString() -> String {
        return self.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines)
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF,   // Misc symbols
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F,   // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
}

// MARK: - Extension UITextField
extension UITextField {
    func setBorder() {
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setPadding(left: CGFloat, right: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
        self.rightViewMode = .always
    }
    
    func setRoundCorner() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
}
