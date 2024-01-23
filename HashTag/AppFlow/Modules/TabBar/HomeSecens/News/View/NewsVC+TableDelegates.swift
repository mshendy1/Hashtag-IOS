//
//  NewsVC+TableDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//


import Foundation
import UIKit

extension NewsVC:UITableViewDelegate,UITableViewDataSource {
    
    func setupTableVC(){
        table.register(UINib(nibName: NewsPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsPostCell.reuseIdentifier)
        
        table.register(UINib(nibName: NewsVedioPostCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsVedioPostCell.reuseIdentifier)

        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.separatorColor = .clear
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return newsVM?.postsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if newsVM?.postsArray?[indexPath.row]?.videoURL == ""{
                    let cell = tableView.dequeueReusableCell(withIdentifier:NewsPostCell.reuseIdentifier) as! NewsPostCell
                    let indx = indexPath.row
                    cell.btnShare.tag = indx
                    cell.btnShare.addTarget(self, action: #selector(sharePostAction), for: .touchUpInside)
                    cell.btnLike.tag = indexPath.row
                    cell.btnLike.addTarget(self, action: #selector(addLikeForPost), for: .touchUpInside)
                   
                    cell.btnFav.tag = indexPath.row
                    cell.btnFav.addTarget(self, action: #selector(addPostToFav), for: .touchUpInside)
                    let isFav = newsVM?.postsBookmarkArry[indexPath.row]
                    if isFav == true {
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = Colors.PrimaryColor
                    }else{
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = .secondaryLabel
                    }
                    cell.configPostsCell(posts:newsVM?.postsArray?[indx])
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
                    let isFav = newsVM?.postsBookmarkArry[indexPath.row]
                    
                    if isFav == true {
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = Colors.PrimaryColor
                    }else{
                        cell.imgFav.image = UIImage.init(named: "FAV")
                        cell.viewFav.backgroundColor = .secondaryLabel
                    }
                    cell.configVideoCell(posts:newsVM?.postsArray?[indx])
                    
                    let bgColorView = UIView()
                    bgColorView.backgroundColor = UIColor.clear
                    cell.selectedBackgroundView = bgColorView
                    
                    return cell
            }
    }
    
    
    @objc func sharePostAction(_ sender:UIButton) {
            let url = newsVM?.postsArray?[sender.tag]?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if newsVM?.postsArray?[indexPath.row]?.videoURL != "" || newsVM?.postsArray?[indexPath.row]?.video != "" {
                    return General.sharedInstance.NewsVideoTablecellHeihht
                }else{
                    return General.sharedInstance.newsPostsTableCellHeight
                }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let index = indexPath.row
                if newsVM?.postsArray?[index]?.videoURL != ""{
                    let id = newsVM?.postsArray?[index]?.id ?? 0
                    let videoUrl = newsVM?.postsArray?[index]?.videoURL ?? ""
                    let video = newsVM?.postsArray?[index]?.video ?? ""
                    newsVM?.delegate?.moveToVideoDetails(id: id, videoUrl: videoUrl,video:video)

                }else{
                    let id = newsVM?.postsArray?[index]?.id ?? 0
                    newsVM?.delegate?.moveToPostDetails(id: id)
                }
    }
    
    
    @objc func addPostToFav(_ sender: UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            guard let indexID = newsVM?.postsArray?[sender.tag]?.id else{return}
            newsVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: uuid )
        }else{
            guard let indexID = newsVM?.postsArray?[sender.tag]?.id else{return}
            newsVM?.addPostsToFavApi(id:indexID, index:sender.tag, deviceId: "" )
        }
    }
    
    @objc func addLikeForPost(_ sender:UIButton) {
        let uuid = UserData.shared.deviceId ?? ""
        let postId = newsVM?.postsArray?[sender.tag]?.id ?? 0
        if !UserDefaults.standard.isLoggedIn(){
            newsVM?.likePostApi(id: postId,index:sender.tag,deviceId:uuid )
        }else{
            newsVM?.likePostApi(id: postId,index:sender.tag,deviceId:"" )

        }
    }
    
    
}
extension NewsVC:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            if position > (table.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !newsVM!.postsIsPagination else {
                    // we already fateching  more data
                    return
                }
                if (newsVM?.lastPageForPosts ?? 1) >= (allPostsPage + 1){
                    allPostsPage += 1
                    print("allPostsPage \(allPostsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: table.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    self.table.tableFooterView = spinner
                    self.table.tableFooterView?.isHidden = false
                    
                    // call api again
                    newsVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }

        
    }
}
