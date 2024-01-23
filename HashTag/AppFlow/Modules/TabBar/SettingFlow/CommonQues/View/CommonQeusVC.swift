//
//  CommonQeusVC.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//
import UIKit

class CommonQeusVC: UIViewController {
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    @IBOutlet weak var tableHeight:NSLayoutConstraint!

    var isIdexExpanded =  [false,false,false]
    var CommonQuesVM:CommonQeusVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.commonQuesTitle
        header.img.isHidden = true
        
        header.switchNotificattion.isHidden = true
        CommonQuesVM = CommonQeusVM(delegate: self)
        callGetCommonQuesApi()
    }

    func callGetCommonQuesApi(){
        if isConnectedToInternet(){
            CommonQuesVM?.getCommonQuesAPI()
        }else{
           showNoInternetAlert()
        }
    }
    


}

extension CommonQeusVC:AuthNavigationDelegate{
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func turAction() {
        
    }
}

