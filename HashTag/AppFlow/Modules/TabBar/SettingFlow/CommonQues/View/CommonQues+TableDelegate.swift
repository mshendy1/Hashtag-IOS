//
//  CommonQues+TableDelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
import UIKit

extension CommonQeusVC: UITableViewDelegate,UITableViewDataSource {
    func setupTableVC(){
        table.register(UINib(nibName: FAQCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier:FAQCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
        table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  CommonQuesVM?.quesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAQCell.reuseIdentifier) as! FAQCell
        cell.stackDetails.isHidden  = !isIdexExpanded[indexPath.row]
        if isIdexExpanded[indexPath.row] {
            cell.img.image = UIImage(systemName: "chevron.up")
            cell.img.tintColor = Colors.textColor
        }else{
            cell.img.image = UIImage(systemName: "chevron.left")
            cell.img.tintColor = Colors.PrimaryColor

        }
        let index = CommonQuesVM?.quesArray?[indexPath.row]
        cell.configur(model:index)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        isIdexExpanded[indexPath.row] = !isIdexExpanded[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
    
}
