//
//  MyEventsVC+TableDelegates.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import UIKit

extension NotificationVC:UITableViewDataSource,UITableViewDelegate{
       
        func setupTable(){
            table.register(UINib(nibName: NotificatiosCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NotificatiosCell.reuseIdentifier)
            table.rowHeight  = UITableView.automaticDimension
            table.estimatedRowHeight = 65
            table.delegate = self
            table.dataSource = self
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return NotificationVM?.notificatiosArray?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier:NotificatiosCell.reuseIdentifier) as! NotificatiosCell
            let index = NotificationVM?.notificatiosArray?[indexPath.row]
                cell.configer(model: index)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
                return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let index = NotificationVM?.notificatiosArray?[indexPath.row]
            NotificationVM?.delegate?.moveTo(type: (index?.type)!, id: (index?.itemID ?? 0))
        }
        
    }
