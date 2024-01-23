//
//  PollsDetailsVC+TableDelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.

import Foundation
import UIKit


extension PollsDetailsVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: AddPollsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AddPollsCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pollsDetailsVM?.surveyDetails?.items?.count ?? 0
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AddPollsCell.reuseIdentifier) as! AddPollsCell
        let model = pollsDetailsVM?.surveyDetails?.items?[indexPath.row]
        
        if !UserDefaults.standard.isLoggedIn(){
            cell.lblName.text = model?.name
            cell.lblCount.text = ""
            cell.lblPercentage.isHidden = true
            cell.votesProgress.isHidden = true
            cell.img.image = UIImage.init(named: "check")
        }else{
            // check if user add this survay before or not
            let choosedCount = (pollsDetailsVM?.surveyDetails?.items ?? []).filter({
                $0.choose == true
            })
            if choosedCount.count != 1 { // mean user not vote before
               cell.votesStack.isHidden = true
                cell.lblCount.isHidden = true
                cell.lblPercentage.isHidden = true
                cell.votesProgress.isHidden = true
            }else{
                cell.votesStack.isHidden = false
                 cell.lblCount.isHidden = false
                 cell.lblPercentage.isHidden = false
                 cell.votesProgress.isHidden = false
                cell.lblName.text = model?.name
                cell.lblCount.text = "\(model?.count ?? 0)\("")"
               
                cell.calculateWidth(items: pollsDetailsVM?.surveyDetails?.items ?? [],index:indexPath.row,tabel: table)
                cell.btnAddPoll.tag = indexPath.row
            }
            if model?.choose == true{
                cell.img.image = UIImage.init(named: "agree1")
            }else{
                cell.img.image = UIImage.init(named: "check")
            }
        }
       
        cell.btnAddPoll.addTarget(self, action: #selector(addPollAction), for: .touchUpInside)

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    

   @objc func addPollAction(_ sender:UIButton) {
    if !UserDefaults.standard.isLoggedIn(){
        moveToLoginSheetVC()
             }else{
        let choosedCount = (pollsDetailsVM?.surveyDetails?.items ?? []).filter({
            $0.choose == true
        })
        if choosedCount.count != 1 {
            let model = pollsDetailsVM?.surveyDetails?.items?[sender.tag]
            if model?.choose == false{
                let id = model?.id
                let surveyId = (pollsDetailsVM?.surveyDetails?.id)!
                pollsDetailsVM?.addPollItemApi(id:id!, surveyId:surveyId,device:"ios")
            }
        }
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
   
    
    
}
