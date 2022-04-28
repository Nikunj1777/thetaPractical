//
//  HomeViewController.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import UIKit

var arrUserModel = [UserModel]()
class HomeViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView! {
        didSet {
            self.tblView.delegate = self
            self.tblView.dataSource = self
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.setDataIntoDataModel()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom method
    func reloadTableviewData() {
        if let userData = DataModel.sharedInstance.getUserData() as? [UserDetail] {
            arrUserModel.removeAll()
            for userDatum in userData {
                if let name = userDatum.name, let email = userDatum.email, let age = userDatum.age {
                    arrUserModel.append(UserModel(name: name, email: email, age: age))
                }
            }
            self.tblView.reloadData()
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.lblName.text = "Name:- \(arrUserModel[indexPath.row].name)"
        cell.lblAge.text = "Age:- \(arrUserModel[indexPath.row].age)"
        cell.lblEmail.text = "Email:- \(arrUserModel[indexPath.row].email)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

// MARK: - Homeview call api method
extension HomeViewController {
    func setDataIntoDataModel() {
        self.activityIndicator.isHidden = false
        DataModel.sharedInstance.deleteUserDetails()
        arrUserModel.removeAll()
        Common.delay(delay: 0.5) {
            self.callRandom10UserData { isSuccess in
                if isSuccess {
                    print(isSuccess)
                    for user in arrUserModel {
                        DataModel.sharedInstance.setUserData(userData: user)
                    }
                    self.reloadTableviewData()
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    func callRandom10UserData(completionHandler: @escaping (Bool) -> Void) {
        var param = [String: Any]()
        param["results"] = 10
        param["page"] = 1
        ApiManager.callRequest(user_api, withParameters: param, header: [:], requestTimeOut: 60) { result in
            
            if let data = result as? [[String: Any]] {
                print(data)
                if data.count > 0 {
                    for user in data {
                        if let email = user["email"] as? String, let name = user["name"] as? String, let age = user["age"] as? Int {
                            if name.contains("@") {
                                arrUserModel.append(UserModel(name: String(name.dropFirst()), email: email, age: "\(age)"))
                            } else if email.first == "@" {
                                arrUserModel.append(UserModel(name: name, email: String(email.dropFirst()), age: "\(age)"))
                            } else {
                                arrUserModel.append(UserModel(name: name, email: email, age: "\(age)"))
                            }
                        }
                    }
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        } failure: { error in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
}
