//
//  MyEventsVC+TableDelegates.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import UIKit

extension MyEventsVC:UITableViewDataSource,UITableViewDelegate{
       
        func setupTable(){
            table.register(UINib(nibName: MyEventsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MyEventsCell.reuseIdentifier)
            table.register(UINib(nibName: EmptyCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EmptyCell.reuseIdentifier)
            table.separatorStyle = .none
            table.separatorColor = .clear
            table.delegate = self
            table.dataSource = self
        }
        
        
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if MyEventsVM?.recentEventsArray?.count == 0 && MyEventsVM?.completedEventsArray?.count == 0 {
            return 1
        }else {
            return 2
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if MyEventsVM?.recentEventsArray?.count == 0 && MyEventsVM?.completedEventsArray?.count == 0{
            return 1
        } else
        if section == 0 {
            return MyEventsVM?.recentEventsArray?.count ?? 0
        }else{
            return MyEventsVM?.completedEventsArray?.count ?? 0
        }
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if MyEventsVM?.recentEventsArray?.count == 0 && MyEventsVM?.completedEventsArray?.count == 0{
                
            let cell = tableView.dequeueReusableCell(withIdentifier:EmptyCell.reuseIdentifier) as! EmptyCell
                cell.btnAddEvent.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
                return cell
            }else
            if  indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier:MyEventsCell.reuseIdentifier) as! MyEventsCell
                let  index = MyEventsVM?.recentEventsArray?[indexPath.row]
                if index?.status == "معتمد"{
                    cell.lblTitle.textColor  = Colors.PrimaryColor
                    cell.imgState.image = UIImage.init(named: "done")
                }else if  index?.status == ""{
                    cell.lblTitle.textColor  = Colors.textColor
                    cell.imgState.image = UIImage.init(named: "cancel")
                }else{
                    cell.lblTitle.textColor  = Colors.textColor
                    cell.imgState.image = UIImage.init(named: "pend")
                }
                cell.configer(model:index)
                return cell
            } else{
                let cell = tableView.dequeueReusableCell(withIdentifier:MyEventsCell.reuseIdentifier) as! MyEventsCell
                    let  index = MyEventsVM?.completedEventsArray?[indexPath.row]
                    if index?.status == "معتمد"{
                        cell.lblTitle.textColor  = Colors.PrimaryColor
                        cell.imgState.image = UIImage.init(named: "done")
                    }else if  index?.status == ""{
                        cell.lblTitle.textColor  = Colors.textColor
                        cell.imgState.image = UIImage.init(named: "cancel")
                    }else{
                        cell.lblTitle.textColor  = Colors.textColor
                        cell.imgState.image = UIImage.init(named: "pend")
                    }
                    cell.configer(model:index)
                    
                let bgColorView = UIView()
                    bgColorView.backgroundColor = UIColor.clear
                    cell.selectedBackgroundView = bgColorView
                    
                    return cell
                }
        }
    
    
    @objc func addEvent(_ sender:UIButton){
        MyEventsVM?.delegate?.createEventTapped()
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 145
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    }
