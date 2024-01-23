//
//  EventsVC+TableDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import UIKit

extension EventsVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: EventsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventsCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.separatorColor = .clear
    }
    
    func setUpCalenderTable(){
        calenderTable.register(UINib(nibName: EventCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventCell.reuseIdentifier)
        calenderTable.delegate = self
        calenderTable.dataSource = self
        calenderTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableView == calenderTable{
            if filteredEvents.count == 0 {
                calenderTable.setEmptyView(title: "", message: "empty")
            }else{
                calenderTable.restore()
            }
            return filteredEvents.count
            
        }else{
            if isFilter == true && eventVM?.filterArray?.count != nil{
                return eventVM?.filterArray?.count ?? 0
            }else{
                return eventVM?.eventsArray?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == calenderTable {
            let cell = tableView.dequeueReusableCell(withIdentifier:EventCell.reuseIdentifier) as! EventCell

            let event = filteredEvents[indexPath.row]
            let time = "\(event?.createdTime ?? "")\n\( event?.timeAmOrPm ?? "")"
            cell.timeLabel.text = time
            cell.titleLabel.text = event?.title ?? ""
            cell.dateLabel.text = event?.all_date ?? ""
            return cell

        } else{                let cell = tableView.dequeueReusableCell(withIdentifier:EventsCell.reuseIdentifier) as! EventsCell
            let index = indexPath.row
            cell.btnFav.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(addEventToFav), for: .touchUpInside)

            if isFilter == true{
                let favindx = eventVM?.filterArray?[indexPath.row]
                if favindx?.bookmark == true {
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = Colors.PrimaryColor
                }else{
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = .secondaryLabel
                }
                if favindx?.video != "" {
                    cell.btnPlay.isHidden = false
                }else{
                    cell.btnPlay.isHidden = false
                }
                cell.configCell(event: eventVM?.filterArray?[index])

            }else{
                let indx = eventVM?.eventsArray?[indexPath.row]
               
                if indx?.video != "" {
                    cell.btnPlay.isHidden = false
                }else{
                    cell.btnPlay.isHidden = false
                }
                if indx?.bookmark == true {
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = Colors.PrimaryColor
                }else{
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = .secondaryLabel
                }
                cell.configCell(event: eventVM?.eventsArray?[index])
            }
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            
            return cell
          }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == calenderTable{
            return General.sharedInstance.calenderEventCellHeight
        }
        else{
            return General.sharedInstance.eventsTableCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = eventVM?.eventsArray?[indexPath.row]?.id ?? 0
        eventVM?.delegate?.moveToEventDetails(id: id)
    }
    
    @objc func addEventToFav(_ sender: UIButton){
       
        if !UserDefaults.standard.isLoggedIn(){
            if isFilter == true {
                guard let indexID = eventVM?.filterArray?[sender.tag]?.id else{return}
                eventVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
            }else{
                guard let indexID = eventVM?.eventsArray?[sender.tag]?.id else{return}
                eventVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
            }
        }else{
            if isFilter == true {
                guard let indexID = eventVM?.filterArray?[sender.tag]?.id else{return}
                eventVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: "" )
            }else{
                guard let indexID = eventVM?.eventsArray?[sender.tag]?.id else{return}
                eventVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: "" )
            }
        }
    }
    
}
extension EventsVC:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
            // fetch more data
            guard !eventVM!.eventsIsPagination else {
                // we already fateching  more data
                return
            }
            if (eventVM?.lastPageForEvents ?? 1) >= (allEventsPage + 1){
                allEventsPage += 1
                print("allPostsPage \(allEventsPage)")
                let spinner = UIActivityIndicatorView(style:.medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                spinner.color = .black
                self.table.tableFooterView = spinner
                self.table.tableFooterView?.isHidden = false
                // call api again
                eventVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCatId, city_id: General.sharedInstance.selectedCountryIdNews, page: allEventsPage)
                
            }else
            {
                //mean we call last page and don't call api again
            }
        }
        
    }
}
