//
//  PostDetails+tableDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/08/1444 AH.
//

import Foundation
import UIKit

extension PostDetailsVC:UITableViewDelegate,UITableViewDataSource {

    func setupTableVC(){
        commentsTable.register(UINib(nibName: CommentsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CommentsCell.reuseIdentifier)
        commentsTable.delegate = self
        commentsTable.dataSource = self
        tableHeight.constant = CGFloat((postDetailsVM.commentsArray?.count ?? 0) * 100)
        self.loadViewIfNeeded()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDetailsVM?.commentsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CommentsCell.reuseIdentifier) as! CommentsCell
        let index = indexPath.row
        cell.imgUser.loadImage(path:self.imagesCommentsArry[index])

        cell.configerCell(model: postDetailsVM?.commentsArray?[index])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
