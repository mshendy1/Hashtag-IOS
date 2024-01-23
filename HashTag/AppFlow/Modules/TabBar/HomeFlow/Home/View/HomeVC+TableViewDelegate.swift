//
//  tableViewDelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import UIKit

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: EventsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventsCell.reuseIdentifier)

        table.register(UINib(nibName: SurveysCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveysCell.reuseIdentifier)
        //MARK:- Trend Cells
        table.register(UINib(nibName: YoutubeCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: YoutubeCell.reuseIdentifier)
        
        table.register(UINib(nibName: TwitterCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TwitterCell.reuseIdentifier)
        
        table.register(UINib(nibName: TrendGoogleNewsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TrendGoogleNewsCell.reuseIdentifier)
        //MARK:- News Cells
        table.register(UINib(nibName: NewsPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsPostCell.reuseIdentifier)
        
        table.register(UINib(nibName: NewsVedioPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsVedioPostCell.reuseIdentifier)
       

        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.separatorColor = .clear
//        viewHeight.constant += tableHeight.constant
//        self.loadViewIfNeeded()
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
            // tableView ==  table
            switch self.selectedType{
            case .news:
                return homeVM?.postsArray?.count ?? 0
            case .events:
                if isFilter == true {
                    return homeVM?.filterArray?.count ?? 0
                }else{
                    return homeVM?.eventsArray?.count ?? 0
                }
            case .surveys:
                return homeVM?.pollsArray?.count ?? 0
            case .twitter:
                return homeVM?.trendTwitterArray?.count ?? 0
            case .youtube:
                return homeVM?.trendYoutubeArray?.count ?? 0
            case .google:
                return homeVM?.trendGoogleArray?.count ?? 0
            case .googleNews:
                return homeVM?.trendGoogleNewsArray?.count ?? 0
            case .none:
                break
            }
            return 0
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

        } else{
            switch self.selectedType{
            case .news:
                if homeVM?.postsArray?[indexPath.row]?.videoURL == ""{
                    let cell = tableView.dequeueReusableCell(withIdentifier:NewsPostCell.reuseIdentifier) as! NewsPostCell
                    let indx = indexPath.row
                    cell.btnShare.tag = indx
                    cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
                    cell.btnLike.tag = indexPath.row
                    cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
                   
                    cell.btnFav.tag = indexPath.row
                    cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                    let isFav = homeVM?.postsBookmarkArry[indexPath.row]
                    if isFav == true {
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = Colors.PrimaryColor
                    }else{
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = .secondaryLabel
                    }
                    cell.configPostsCell(posts:homeVM?.postsArray?[indx])
                    let bgColorView = UIView()
                    bgColorView.backgroundColor = UIColor.clear
                    cell.selectedBackgroundView = bgColorView
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier:NewsVedioPostCell.reuseIdentifier) as! NewsVedioPostCell
                    let indx = indexPath.row
                    cell.btnShare.tag = indx
                    cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
                    
                    cell.btnLike.tag = indexPath.row
                    cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
                   
                    cell.btnFav.tag = indexPath.row
                    cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                    let isFav = homeVM?.postsBookmarkArry[indexPath.row]
                    
                    if isFav == true {
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = Colors.PrimaryColor
                    }else{
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = .secondaryLabel
                    }
                    cell.configVideoCell(posts:homeVM?.postsArray?[indx])
                    
                    let bgColorView = UIView()
                    bgColorView.backgroundColor = UIColor.clear
                    cell.selectedBackgroundView = bgColorView
                    
                    return cell
                }
            case .events:
                let cell = tableView.dequeueReusableCell(withIdentifier:EventsCell.reuseIdentifier) as! EventsCell
                let index = indexPath.row
                cell.btnFav.tag = indexPath.row
                cell.btnFav.addTarget(self, action: #selector(addEventToFav), for: .touchUpInside)

                if isFilter == true{
                    let favindx = homeVM?.filterArray?[indexPath.row]
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
                    cell.configCell(event: homeVM?.filterArray?[index])

                }else{
                    let indx = homeVM?.eventsArray?[indexPath.row]
                   
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
                    cell.configCell(event: homeVM?.eventsArray?[index])
                }
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
                
            case .surveys:
                let cell = tableView.dequeueReusableCell(withIdentifier:SurveysCell.reuseIdentifier) as! SurveysCell
                let index = indexPath.row
                cell.btnFav.tag = indexPath.row
                cell.btnFav.addTarget(self, action: #selector(addPoolsToFav), for: .touchUpInside)
                let favindx = homeVM?.pollsArray?[indexPath.row]
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
                cell.configPollCell(model:homeVM?.pollsArray?[index])
                
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
                
            case .twitter:
                let cell = tableView.dequeueReusableCell(withIdentifier:TwitterCell.reuseIdentifier) as! TwitterCell
                if indexPath.row == 0
                {
                    cell.lineLbl.isHidden = true
                }else
                {
                    cell.lineLbl.isHidden = false
                }
                let index = indexPath.row
                cell.configTwitterCell(model: homeVM?.trendTwitterArray?[index])
                cell.lblNum.text = "\(indexPath.row + 1)"
                
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
                
            case .youtube:
                let cell = tableView.dequeueReusableCell(withIdentifier:YoutubeCell.reuseIdentifier) as! YoutubeCell
                let index = indexPath.row
                cell.configCellWithModel(model: homeVM?.trendYoutubeArray?[index])
                
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
                
            case .google:
                let cell = tableView.dequeueReusableCell(withIdentifier:TwitterCell.reuseIdentifier) as! TwitterCell
                cell.lblNum.text = "\(indexPath.row + 1)"
                let index = indexPath.row
                cell.configeNewsCell(model: homeVM?.trendGoogleArray?[index])
                if indexPath.row == 0
                {
                    cell.lineLbl.isHidden = true
                }else
                {
                    cell.lineLbl.isHidden = false
                }
                
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
            case .googleNews:
                let cell = tableView.dequeueReusableCell(withIdentifier:TrendGoogleNewsCell.reuseIdentifier) as! TrendGoogleNewsCell
                let index = indexPath.row
                cell.configCell(model: homeVM?.trendGoogleNewsArray?[index])
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                return cell
            case .none:
                break
            }
            return UITableViewCell()
        }
    }
    
    
    @objc func sharePostAction(_ sender:UIButton) {
            let url = homeVM?.postsArray?[sender.tag]?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }
    
    @objc func shareSurvayAction(_ sender:UIButton){
            let titleUrl = homeVM?.pollsArray?[sender.tag]?.title ?? ""
            let desUrl = (homeVM?.pollsArray?[sender.tag]?.des ?? "").htmlToString
            loginAlertVM?.shareSurvay(titleUrl: titleUrl, desUrl: desUrl, presenter: self, sender: sender)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == calenderTable{
            return 72
        }
        else
        {
            switch self.selectedType{
            case .news:
                if homeVM?.postsArray?[indexPath.row]?.videoURL != "" || homeVM?.postsArray?[indexPath.row]?.video != "" {
                    return NewsVideoTablecellHeihht
                }else{
                    return newsPostsTableCellHeight
                }
            case .events:
                return eventsTableCellHeight
            case .surveys:
                return surveysTableCellHeight
            case .twitter:
                return twitterTableCellHeight
            case .youtube:
                return youtubeTableCellHeight
            case .google:
                return twitterTableCellHeight
            case .googleNews:
                return googleNewsTableCellHeight
            case .none:
                break
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            switch self.selectedType{
            case .news:
                let index = indexPath.row
                if homeVM?.postsArray?[index]?.videoURL != ""{
                    let id = homeVM?.postsArray?[index]?.id ?? 0
                    let videoUrl = homeVM?.postsArray?[index]?.videoURL ?? ""
                    let video = homeVM?.postsArray?[index]?.video ?? ""
                    homeVM?.outputDelegate?.moveToVideoDetails(id: id, videoUrl: videoUrl,video:video)

                }else{
                    let id = homeVM?.postsArray?[index]?.id ?? 0
                    homeVM?.outputDelegate?.moveToPostDetails(id: id)
                }
                return
            case .events:
                let id = homeVM?.eventsArray?[indexPath.row]?.id ?? 0
                homeVM?.outputDelegate?.moveToEventDetails(id: id)
                return
            case .surveys:
//                let id = homeVM?.pollsArray?[indexPath.row]?.id ?? 0
//                homeVM?.delegate?.moveToPollDetails(id: id)
                return
            case .twitter:
                let twitterKeyword = homeVM?.trendTwitterArray?[indexPath.row]?.query ?? ""
                  homeVM?.outputDelegate?.trendTwitterTapped(tex: twitterKeyword)
                return
            case .youtube:
                let indexUrl = homeVM?.trendYoutubeArray?[indexPath.row]?.url ?? ""
                homeVM?.outputDelegate?.youtubeTapped(url: indexUrl)
                return
            case .google:
                let indexUrl = homeVM?.trendGoogleArray?[indexPath.row]?.title ?? ""
                homeVM?.outputDelegate?.trendGoogleTapped(url: indexUrl)
                return
            case .googleNews:
                let indexUrl = homeVM?.trendGoogleNewsArray?[indexPath.row]?.url ?? ""
                homeVM?.outputDelegate?.trendGoogleNewsTapped(url: indexUrl)
                return
            case .none:
                break
            }
    }
    
    
    @objc func addPostToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = homeVM?.postsArray?[sender.tag]?.id else{return}
            homeVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = homeVM?.postsArray?[sender.tag]?.id else{return}
            homeVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: "" )
        }
    }
    
    @objc func showPollDetails(_ sender: UIButton){
        guard let indexID = homeVM?.pollsArray?[sender.tag]?.id else{return}
        homeVM?.outputDelegate?.moveToPollDetails(id: indexID)
    }
    
    @objc func addEventToFav(_ sender: UIButton){
       
        if !UserDefaults.standard.isLoggedIn(){
            if isFilter == true {
                guard let indexID = homeVM?.filterArray?[sender.tag]?.id else{return}
                homeVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
            }else{
                guard let indexID = homeVM?.eventsArray?[sender.tag]?.id else{return}
                homeVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
            }
        }else{
            if isFilter == true {
                guard let indexID = homeVM?.filterArray?[sender.tag]?.id else{return}
                homeVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: "" )
            }else{
                guard let indexID = homeVM?.eventsArray?[sender.tag]?.id else{return}
                homeVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: "" )
            }
        }
    }
    
    @objc func addPoolsToFav(_ sender: UIButton){
   
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = homeVM?.pollsArray?[sender.tag]?.id else{return}
            homeVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = homeVM?.pollsArray?[sender.tag]?.id else{return}
            homeVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: "")
        }
    }
    
    @objc func addLikeForPost(_ sender:UIButton) {
        let uuid = UserData.shared.deviceId ?? ""
        let postId = homeVM?.postsArray?[sender.tag]?.id ?? 0
        if !UserDefaults.standard.isLoggedIn(){
            homeVM?.likePostApi(id: postId,index:sender.tag,deviceId:uuid )
        }else{
            homeVM?.likePostApi(id: postId,index:sender.tag,deviceId:"" )

        }
    }
    
    
}
extension HomeVC:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.selectedType == .news{
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !homeVM!.postsIsPagination else {
                    // we already fateching  more data
                    return
                }
                
                if (homeVM?.lastPageForPosts ?? 1) >= (allPostsPage + 1){
                    allPostsPage += 1
                    print("allPostsPage \(allPostsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    homeVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }
        }else if self.selectedType == .events{
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !homeVM!.eventsIsPagination else {
                    // we already fateching  more data
                    return
                }
                
                if (homeVM?.lastPageForEvents ?? 1) >= (allEventsPage + 1){
                    allEventsPage += 1
                    print("allPostsPage \(allEventsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    homeVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allEventsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }
            
        }else if self.selectedType == .surveys{
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !homeVM!.pollsIsPagination else {
                    // we already fateching  more data
                    return
                }
                
                if (homeVM?.lastPageForPolls ?? 1) >= (allPollsPage + 1){
                    allPollsPage += 1
                    print("allPollsPage \(allPollsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    homeVM?.callGetPollsApi(page: allPollsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }
            
            
        }
        
    }
}
