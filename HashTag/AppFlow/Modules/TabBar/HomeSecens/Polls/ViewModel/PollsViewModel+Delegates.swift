//
//  PollsViewModel+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation


extension PollsVC:PollsViewModelDelegates{
    func showLoading(){
        startLoadingIndicator()
    }
    func killLoading(){
        stopLoadingIndicator()
    }
    func connectionFailed(){
        showNoInternetAlert()
    }
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }
    
    func reloadPollsData() {
        if PollsVM?.pollsArray?.count == 0 ||  PollsVM?.pollsArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
    }
    
    func moveToPollDetails(id: Int) {
        let vc = PollsDetailsVC()
        vc.surveyID = id
        self.navigationController?.pushViewController(vc, animated: true)
}
    
    func addToFavSuccessfully(index: Int, type: Types) {
            let bookMark = PollsVM?.pollsArray![index]!.bookmark
            PollsVM?.pollsArray![index]?.bookmark = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        }
    
    
}
// MARK: - LoginAlertViewModelDelegates --->
extension PollsVC:LoginAlertViewModelDelegates{
        func openAppStore() {}
        func checkIfUserLoggedIn(){}
        func LoginActionSuccess() {moveToLogin()}
        func logoutActionSuccess() {}
        func moveToLogin(){
            let vc = LoginVC()
            General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
        }
}
