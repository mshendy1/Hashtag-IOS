
//  FavouritesVC+TableDelegates.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.


import Foundation
import UIKit

extension SearchOutsVC:UITableViewDelegate,UITableViewDataSource {

    
    
    func setupTableVC(){
        table.register(UINib(nibName: EventsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventsCell.reuseIdentifier)

        table.register(UINib(nibName: SurveysCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SurveysCell.reuseIdentifier)
    
        table.register(UINib(nibName: NewsPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsPostCell.reuseIdentifier)
      
        table.register(UINib(nibName: NewsVedioPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsVedioPostCell.reuseIdentifier)
    
        table.delegate = self
        table.dataSource = self
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch self.type{
        case .news:
            return searchOutsVM?.SearchPostsArray?.count ?? 0
        case .events:
            return searchOutsVM?.SearchEventssArr?.count ?? 0
        case .surveys:
            return searchOutsVM?.SearchpollsArray?.count ?? 0
        case .none:
            break
        }
        
       return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.type{
        case .news:
            if searchOutsVM?.SearchPostsArray?[indexPath.row]?.videoURL == ""{
                let cell = tableView.dequeueReusableCell(withIdentifier:NewsPostCell.reuseIdentifier) as! NewsPostCell
                let index = searchOutsVM?.SearchPostsArray?[indexPath.row]
                
                let indx = indexPath.row
                cell.btnShare.tag = indx
                cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)

                cell.btnLike.tag = indx
                cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
               
                cell.btnFav.tag = indx
                cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                let favindx = searchOutsVM?.SearchPostsArray?[indexPath.row]
                if favindx?.bookmark == true {
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = Colors.PrimaryColor
                }else{
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = .secondaryLabel
                }
                cell.configSearchPostsCell(Posts: index)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier:NewsVedioPostCell.reuseIdentifier) as! NewsVedioPostCell
                let index = searchOutsVM?.SearchPostsArray?[indexPath.row]
                let indx = indexPath.row
                cell.btnShare.tag = indx
                cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
                
                cell.btnLike.tag = indexPath.row
                cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
               
                cell.btnFav.tag = indexPath.row
                cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                let favindx = searchOutsVM?.SearchPostsArray?[indexPath.row]
                if favindx?.bookmark == true {
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor = Colors.PrimaryColor
                }else{
                    cell.imgFav.image = UIImage.init(named: "FAV")
                    cell.viewFav.backgroundColor =  .secondaryLabel
                }

                cell.configSearchVideoCell(posts:index)
                return cell
            }
        case .events:
            let cell = tableView.dequeueReusableCell(withIdentifier:EventsCell.reuseIdentifier) as! EventsCell
            let indx = searchOutsVM?.SearchEventssArr?[indexPath.row]
            
            let index = indexPath.row
            cell.btnFav.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(addEventToFav), for: .touchUpInside)
            if indx?.video != "" {
                cell.btnPlay.isHidden = false
            }else{
                cell.btnPlay.isHidden = false
            }
            let favindx = searchOutsVM?.SearchEventssArr?[indexPath.row]
            if favindx?.bookmark == true {
                cell.imgFav.image = UIImage.init(named: "FAV")
                cell.viewFav.backgroundColor = Colors.PrimaryColor
            }else{
                cell.imgFav.image = UIImage.init(named: "FAV")
                cell.viewFav.backgroundColor =  .secondaryLabel
            }
            cell.configSearchCell(event: indx)
            return cell

        case .surveys:
            let cell = tableView.dequeueReusableCell(withIdentifier:SurveysCell.reuseIdentifier) as! SurveysCell
            let index = searchOutsVM?.SearchpollsArray?[indexPath.row]
            
            let indx = indexPath.row
            cell.btnFav.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(addPoolsToFav), for: .touchUpInside)
            let favindx = searchOutsVM?.SearchpollsArray?[indexPath.row]
            if favindx?.bookmark == true {
                cell.imgFav.image = UIImage.init(named: "FAV")
                cell.viewFav.backgroundColor = Colors.PrimaryColor
            }else{
                cell.imgFav.image = UIImage.init(named: "FAV")
                cell.viewFav.backgroundColor =  .secondaryLabel
            }
            cell.btnShare.tag = indx
            cell.btnShare.addTarget(self, action: #selector(shareSurvayAction), for: .touchUpInside)
            cell.configSearchPoll(model:index)
            return cell
            
        case .none:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.type{
        case .news:
            if searchOutsVM?.SearchPostsArray?[indexPath.row]?.videoURL != ""{
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
            if searchOutsVM?.SearchPostsArray?[index]?.videoURL != ""{
                let id = searchOutsVM?.SearchPostsArray?[index]?.id
                let vc = PostDetailsVC()
                vc.postId = id
                vc.video_Url = searchOutsVM?.SearchPostsArray?[index]?.videoURL
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let id = searchOutsVM?.SearchPostsArray?[index]?.id
                let vc = PostDetailsVC()
                vc.postId = id
                vc.video_Url = searchOutsVM?.SearchPostsArray?[index]?.videoURL
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return
        case .events:
            let id = searchOutsVM?.SearchEventssArr?[indexPath.row]?.id
            let vc = EventsDetailsVC()
            vc.eventId = id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case .surveys:
            return
        case .none:
            break
        }
        return
    }
    
    
    
    
    
    @objc func addPostToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = searchOutsVM?.SearchPostsArray?[sender.tag]?.id else{return}
            searchOutsVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = searchOutsVM?.SearchPostsArray?[sender.tag]?.id else{return}
            searchOutsVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: "" )
        }
        }
    
    @objc func addEventToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = searchOutsVM?.SearchEventssArr?[sender.tag]?.id else{return}
            searchOutsVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
                guard let indexID = searchOutsVM?.SearchEventssArr?[sender.tag]?.id else{return}
            searchOutsVM?.addEventToFavApi(id:indexID, index:sender.tag, deviceId: "" )
            
          }
        }
    @objc func addPoolsToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = searchOutsVM?.SearchpollsArray?[sender.tag]?.id else{return}
            searchOutsVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = searchOutsVM?.SearchpollsArray?[sender.tag]?.id else{return}
            searchOutsVM?.addPollsToFavApi(id:indexID, index:sender.tag, deviceId: "")
            }
        }
  
    @objc func addLikeForPost(_ sender:UIButton) {
        let postId = searchOutsVM?.SearchPostsArray?[sender.tag]?.id ?? 0
        let uuid = UserData.shared.deviceId ?? ""
       
        if !UserDefaults.standard.isLoggedIn(){
            searchOutsVM?.likePostApi(id: postId,index:sender.tag, deviceId:uuid )
        }else{
            searchOutsVM?.likePostApi(id: postId,index:sender.tag, deviceId:"")
        }
    }
    
    @objc func sharePostAction(_ sender:UIButton){
            let url = searchOutsVM?.SearchPostsArray?[sender.tag]?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }
    
    @objc func shareSurvayAction(_ sender:UIButton){
            let titleUrl = searchOutsVM?.SearchpollsArray?[sender.tag]?.title ?? ""
            let desUrl = (searchOutsVM?.SearchpollsArray?[sender.tag]?.des ?? "").htmlToString

            loginAlertVM?.shareSurvay(titleUrl: titleUrl, desUrl: desUrl, presenter: self, sender: sender)
    }
    
}
