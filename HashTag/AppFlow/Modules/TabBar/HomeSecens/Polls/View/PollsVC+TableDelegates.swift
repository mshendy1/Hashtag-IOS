//
//  PollsVC+TableDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import UIKit

extension PollsVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: SurveysCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveysCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.separatorColor = .clear
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PollsVM?.pollsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:SurveysCell.reuseIdentifier) as! SurveysCell
        let index = indexPath.row
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(addPoolsToFav), for: .touchUpInside)
        let favindx = PollsVM?.pollsArray?[indexPath.row]
        if favindx?.bookmark == true {
            cell.imgFav.image = UIImage.init(named: "FAV")
            cell.viewFav.backgroundColor = Colors.PrimaryColor
        }else{
            cell.imgFav.image = UIImage.init(named: "FAV")
            cell.viewFav.backgroundColor = .secondaryLabel
        }
        
        cell.btnShowDetails.tag = index
        cell.btnShowDetails.addTarget(self, action: #selector(showPollDetails), for: .touchUpInside)
        cell.btnShare.tag = index
        cell.btnShare.addTarget(self, action: #selector(shareSurvayAction), for: .touchUpInside)
        cell.configPollCell(model:PollsVM?.pollsArray?[index])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    

    
    @objc func shareSurvayAction(_ sender:UIButton){
            let titleUrl = PollsVM?.pollsArray?[sender.tag]?.title ?? ""
            let desUrl = (PollsVM?.pollsArray?[sender.tag]?.des ?? "").htmlToString
//            loginAlertVM?.shareSurvay(titleUrl: titleUrl, desUrl: desUrl, presenter: self, sender: sender)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return General.sharedInstance.surveysTableCellHeight
    }
    

    

    
    @objc func showPollDetails(_ sender: UIButton){
        guard let indexID = PollsVM?.pollsArray?[sender.tag]?.id else{return}
        PollsVM?.delegate?.moveToPollDetails(id: indexID)
    }
    

    
    @objc func addPoolsToFav(_ sender: UIButton){
   
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = PollsVM?.pollsArray?[sender.tag]?.id else{return}
            PollsVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = PollsVM?.pollsArray?[sender.tag]?.id else{return}
            PollsVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: "")
        }
    }
    

    
    
}
extension PollsVC:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !PollsVM!.pollsIsPagination else {
                    // we already fateching  more data
                    return
                }
                if (PollsVM?.lastPageForPolls ?? 1) >= (allPollsPage + 1){
                    allPollsPage += 1
                    print("allPollsPage \(allPollsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    PollsVM?.callGetPollsApi(page: allPollsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }
    }
}
