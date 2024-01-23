//
//  FavouritesVC+TableDelegates.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation
import UIKit


extension FavouritesVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: EventsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventsCell.reuseIdentifier)

        table.register(UINib(nibName: SurveysCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveysCell.reuseIdentifier)
    
        table.register(UINib(nibName: NewsPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsPostCell.reuseIdentifier)
      
        table.register(UINib(nibName: NewsVedioPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsVedioPostCell.reuseIdentifier)
    
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
//        tableHeight.constant = 5 * 305
//        viewHeight.constant += tableHeight.constant - 500
//        self.loadViewIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch self.type{
        case .news:
            return FavouritsVM?.postsArray?.count ?? 0
        case .events:
            return FavouritsVM?.eventsArray?.count ?? 0
        case .surveys:
            return FavouritsVM?.pollsArray?.count ?? 0
        case .none:
            break
        }
        
       return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.type{
        case .news:
            if FavouritsVM?.postsArray?[indexPath.row]?.videoURL == ""{
                let cell = tableView.dequeueReusableCell(withIdentifier:NewsPostCell.reuseIdentifier) as! NewsPostCell
        //MARK:- Share
                let indx = indexPath.row
                cell.btnShare.tag = indx
                cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
        //MARK:- Add Like
                cell.btnLike.tag = indexPath.row
                cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
        //MARK:- AddTO FAV
                cell.btnFav.tag = indexPath.row
                cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                                
                cell.configFavPostsCell(favPosts:FavouritsVM?.postsArray?[indx])
               
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier:NewsVedioPostCell.reuseIdentifier) as! NewsVedioPostCell
                let indx = indexPath.row
        //MARK:- Share
                cell.btnShare.tag = indx
                cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
        //MARK:- Add Like
                cell.btnLike.tag = indexPath.row
                cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
        //MARK:- AddTO FAV
                cell.btnFav.tag = indexPath.row
                cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                cell.configFavVideoCell(favPosts:FavouritsVM?.postsArray?[indx])
                
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
                cell.configCell(event: FavouritsVM?.eventsArray?[index])
            cell.configCell(event: FavouritsVM?.eventsArray?[index])
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            
            return cell

        case .surveys:
            let cell = tableView.dequeueReusableCell(withIdentifier:SurveysCell.reuseIdentifier) as! SurveysCell
            let index = indexPath.row
     //MARK:- AddTO FAV
            cell.btnFav.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(addPoolsToFav), for: .touchUpInside)
            cell.imgFav.image = UIImage.init(named: "FAV")
            cell.viewFav.backgroundColor = Colors.PrimaryColor
    //MARK:- Share
            cell.btnShare.tag = index
            cell.btnShare.addTarget(self, action: #selector(shareSurvayAction), for: .touchUpInside)
            cell.configPollCell(model:FavouritsVM?.pollsArray?[index])
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            
            return cell
            
        case .none:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.type{
        case .news:
            if FavouritsVM?.postsArray?[indexPath.row]?.videoURL != ""{
                return NewsVideoTablecellHeihht
            }else{
                return newsPostsTableCellHeight
            }
        case .events:
            return eventsTableCellHeight
        case .surveys:
            return surveysTableCellHeight
        case .none:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.type{
        case .news:
            let index = indexPath.row
           if FavouritsVM?.postsArray?[index]?.videoURL != ""{
                let id = FavouritsVM?.postsArray?[index]?.id
                let vc = PostDetailsVC()
                vc.postId = id
                vc.video_Url = FavouritsVM?.postsArray?[index]?.videoURL
                self.navigationController?.pushViewController(vc, animated: true)
           }else{
                let id = FavouritsVM?.postsArray?[index]?.id
                let vc = PostDetailsVC()
                vc.postId = id
                vc.video_Url = FavouritsVM?.postsArray?[index]?.videoURL
                self.navigationController?.pushViewController(vc, animated: true)
             }
            return
        case .events:
            let id = FavouritsVM?.eventsArray?[indexPath.row]?.id
            let vc = EventsDetailsVC()
            vc.eventId = id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case .surveys:
            let id = FavouritsVM?.pollsArray?[indexPath.row]?.id
            let vc = PollsDetailsVC()
            vc.surveyID = id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case .none:
            break
        }
        return
    }
    
    @objc func addPostToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = FavouritsVM?.postsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addPostsToFavApi(id:indexID, deviceId: uuid ?? "", index:sender.tag )
        }else{
            guard let indexID = FavouritsVM?.postsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addPostsToFavApi(id:indexID, deviceId: "" , index:sender.tag )
        }
        }
    
    @objc func addEventToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = FavouritsVM?.eventsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addEventToFavApi(id:indexID, deviceId: uuid ?? "", index:sender.tag )
        }else{
                guard let indexID = FavouritsVM?.eventsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addEventToFavApi(id:indexID, deviceId: "" , index:sender.tag )
            
        }
        }
    @objc func addPoolsToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = FavouritsVM?.pollsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addPollsToFavApi(id:indexID, deviceId: uuid ?? "" , index:sender.tag )
        }else{
            guard let indexID = FavouritsVM?.pollsArray?[sender.tag]?.id else{return}
            FavouritsVM?.addPollsToFavApi(id:indexID, deviceId:"", index:sender.tag )
            }
        }
  
    @objc func addLikeForPost(_ sender:UIButton) {
        let postId = FavouritsVM?.postsArray?[sender.tag]?.id ?? 0
        if !UserDefaults.standard.isLoggedIn(){
            let uuid = UserData.shared.deviceId ?? ""
            FavouritsVM?.likePostApi(id: postId,index:sender.tag,deviceId:uuid )
        }else{
            FavouritsVM?.likePostApi(id: postId,index:sender.tag,deviceId: "" )
        }
    }
    
    @objc func sharePostAction(_ sender:UIButton){
            let url = FavouritsVM?.postsArray?[sender.tag]?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }


    @objc func shareSurvayAction(_ sender:UIButton){
            let titleUrl = FavouritsVM?.pollsArray?[sender.tag]?.title ?? ""
            let desUrl = (FavouritsVM?.pollsArray?[sender.tag]?.des ?? "").htmlToString
            loginAlertVM?.shareSurvay(titleUrl: titleUrl, desUrl: desUrl, presenter: self, sender: sender)
    }

    
}
