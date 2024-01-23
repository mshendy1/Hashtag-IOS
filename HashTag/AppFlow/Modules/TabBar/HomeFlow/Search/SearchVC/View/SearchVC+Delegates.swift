//
//  SearchVC+Delegates.swift
//  E-CommerceApp
//
//  Created by Eman Gaber on 27/06/2022.
//

import Foundation
import UIKit
    extension SearchVC:UITableViewDelegate,UITableViewDataSource {
        
        func setupTableVC(){
            table.register(UINib(nibName: SearchCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchCell.reuseIdentifier)
            table.delegate = self
            table.dataSource = self
            table.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchVM.searchItemsArr?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier) as! SearchCell
            let index = searchVM.searchItemsArr?[indexPath.row]
            cell.lbltitle.text = index?.htmlToString
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let array = searchVM?.searchItemsArr?[indexPath.row]
            let vc = SearchOutsVC()
            vc.searchKeyWord = array
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
