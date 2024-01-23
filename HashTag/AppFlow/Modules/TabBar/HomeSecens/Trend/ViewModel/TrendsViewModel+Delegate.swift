//
//  TrendsViewModel+Delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation

extension TrendsVC:TrendsViewModelDelegates{
   
    func reloadTableAndCollection(){
        self.trendCollection.reloadData()
        self.table.reloadData()
    }

    func showLoading() {
        startLoadingIndicator()
    }
    func killLoading() {
        stopLoadingIndicator()
    }
    func connectionFailed(){
        showNoInternetAlert()
    }
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }

    func trendGoogleNewsTapped(url:String) {
        let vc = WebViewVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func trendGoogleTapped(url:String) {
        let vc = WebViewVC()
        vc.url = "https://www.google.com/search?q=\(url)".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func youtubeTapped(url:String) {
        let vc = WebViewVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func trendTwitterTapped(tex:String) {
        let vc = WebViewVC()
        vc.text = tex
        vc.twitter = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getTwitterTrendSuccessfully(model: [TrendTwitterModel?]?) {
        if trendVM?.trendTwitterArray?.count == 0 || trendVM?.trendTwitterArray?.count == nil {
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
         }else{
             table.restore()
       }
        table.reloadData()
    }
}
