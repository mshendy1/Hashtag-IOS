//
//  MyEventsVC.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import UIKit
enum MyEvetsType {
    case recent
    case complete
}
class MyEventsVC: UIViewController {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var addEventView:UIView!
    @IBOutlet weak var header:AuthNavigation!
    var type : MyEvetsType!
    var fromHome:Bool?
    var MyEventsVM:MyEventsViewModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.myEventsTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        MyEventsVM = MyEventsViewModel(delegate: self)
        addEventView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        callApi()
        setupTable()
    }
    
    func callApi(){
        if isConnectedToInternet(){
            MyEventsVM?.callGetMyEventsApi()
        }else{
            MyEventsVM?.delegate?.connectionFailed()
        }
    }
    
    
    @IBAction func openCreateEventVC(_ sender:UIButton){
        MyEventsVM?.delegate?.createEventTapped()
    }
    


}

extension MyEventsVC: AuthNavigationDelegate{
    func turAction() {
        
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
 
    func backAction() {
        if fromHome == true{
            backTwo()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
