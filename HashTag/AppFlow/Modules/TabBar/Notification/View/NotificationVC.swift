//
//  MyEventsVC.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var header:AuthNavigation!
    var type : MyEvetsType!
    var NotifisIsPagination = false
    var NotificationVM:NotificationViewModel?
    var allNotificationsPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupTable()
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.notificationsTitle
        header.img.isHidden = true
        header.btnBack.isHidden = true
        NotificationVM = NotificationViewModel(delegate: self)
        
        if UserDefaults.standard.isNotification(){
            header.switchNotificattion.isOn = true
        }else{
            header.switchNotificattion.isOn = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        callgetNotificationApi(page: allNotificationsPage)
        let tabBarController = self.tabBarController as? SSCustomTabBarViewController
       General.sharedInstance.notificationCount = ""
        tabBarController?.addOrUpdateBadgeValueAtIndex(index: 2, value: "")
        tabBarController?.removeAllBadges()
    }
    
    func callSwitchNotificationApi(devide:String,id:Int){
        if isConnectedToInternet(){
            NotificationVM?.switchNotificationsApi(id: id, deviceId:devide )
        }else{
            NotificationVM?.delegate?.connectionFailed()
        }
    }
    
    func callgetNotificationApi(page:Int){
        if isConnectedToInternet(){
            NotificationVM?.callGetNotifications(page: allNotificationsPage)
        }else{
            NotificationVM?.delegate?.connectionFailed()
        }
    }
 

}

extension NotificationVC:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !NotificationVM!.NotifisIsPagination else {
                    // we already fateching  more data
                    return
                }
                
                if (NotificationVM?.lastPageFor ?? 1) >= (allNotificationsPage + 1){
                    allNotificationsPage += 1
                    print("allNotificationsPage \(allNotificationsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    NotificationVM?.callGetNotifications(page: allNotificationsPage)

                    
                    
                }else
                {
                    //mean we call last page and don't call api again
                }
            }
        
    }
}

extension NotificationVC: AuthNavigationDelegate{
    func turAction() {
        if UserDefaults.standard.isLoggedIn(){
            guard let userId = UserData.shared.userDetails?.id else{return}
            callSwitchNotificationApi(devide:"", id:userId)
        }else{
            let uuid = UserData.shared.deviceId ?? ""
            callSwitchNotificationApi(devide:uuid,id:0)
        }
        
        
    }
   
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
