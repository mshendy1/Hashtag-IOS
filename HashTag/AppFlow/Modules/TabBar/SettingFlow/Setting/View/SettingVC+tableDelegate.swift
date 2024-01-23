//
//  SettingVC+tableDelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import Foundation
import UIKit

extension SettingVC:UITableViewDataSource,UITableViewDelegate{
   
    func setupTable(){
        table.register(UINib(nibName: SettingsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SettingsCell.reuseIdentifier)
       
        table.register(UINib(nibName: LogoutCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LogoutCell.reuseIdentifier)
       
        table.register(UINib(nibName: LoginCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LoginCell.reuseIdentifier)
        table.cornerRadius = 15
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        self.loadViewIfNeeded()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            if UserDefaults.standard.isLoggedIn() {
                return 8
            }else{
                return 7
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0{
            if UserDefaults.standard.isLoggedIn(){
                let cell = tableView.dequeueReusableCell(withIdentifier:LogoutCell.reuseIdentifier) as! LogoutCell
                var img = ""
            
                if userData?.photo == "" {
                    img = UserDefaults.standard.getUserImage()
                }else {
                    var  img = userData?.photo ?? ""
                }
                cell.img.loadImage(path: img,placeHolderImage: UIImage(named: "man"))
                if General.sharedInstance.socialLoginType == Constants.appWords.apple {
                    cell.nameLbl.text = KeychainItem.currentUserName
                }
               else{
                   cell.nameLbl.text = UserData.shared.userDetails?.name ?? ""
                }
                cell.btnLout.tag = indexPath.row
                cell.btnLout.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
                // Add the tap gesture recognizer to the label
                cell.logoutLbl.addGestureRecognizer(tapGesture)
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
            return cell

            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier:LoginCell.reuseIdentifier) as! LoginCell
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                return cell
            }
        }
        let indx = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier:SettingsCell.reuseIdentifier) as! SettingsCell
        cell.img.image = UIImage(named: General.sharedInstance.settingImgs[indx])
        cell.titleLbl.text = General.sharedInstance.settingTitles[indx]
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            
            if UserDefaults.standard.isLoggedIn() || indexPath.row == 0{
                return  74
            }else{
                return 47
            }
        }else{
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            
            if  indexPath.row == 0{
                if !UserDefaults.standard.isLoggedIn()
                {
                settingVM?.delegate?.moveToLoginSheetVC()
                }
                else{
                    loginAlertVM?.logoutAlert(presenter: self)
                }
            }
        }else{
            let indx = indexPath.row
            switch indx {
            case 0:
                if !UserDefaults.standard.isLoggedIn(){
                    settingVM?.delegate?.moveToLoginSheetVC()
                }else{
                    settingVM?.delegate?.moveToProfile()
                }
            case 1:
                let vc =  SelectCategoriesVC()
                self.navigationController?.pushViewController(vc, animated: true)

            case 2:
                if !UserDefaults.standard.isLoggedIn(){
                    settingVM?.delegate?.moveToLoginSheetVC()
                }else{
                    settingVM?.delegate?.moveToMyEvents()
                }
            case 3:
                settingVM?.delegate?.moveToContactUs()
            case 4:
                settingVM?.delegate?.moveToCommonQues()
            case 5:
                let vc =  PrivacyAndPolicyVC()
                vc.type = "privacy"
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc =  PrivacyAndPolicyVC()
                vc.type = "terms"
                self.navigationController?.pushViewController(vc, animated: true)
            case 7:
                 self.deleteUserAction()
            default:
                break
            }
        }
    }
    
    @objc func logoutTapped(){
        loginAlertVM?.logoutAlert(presenter: self)
    }
}
