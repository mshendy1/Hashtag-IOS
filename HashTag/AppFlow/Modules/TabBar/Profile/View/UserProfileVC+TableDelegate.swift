//
//  File.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
import UIKit

//extension UserProfileVC:UITableViewDelegate,UITableViewDataSource{
//    func setupTableVC(){
//        table.register(UINib(nibName: DropdownTCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DropdownTCell.reuseIdentifier)
//        table.delegate = self
//        table.dataSource = self
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier:DropdownTCell.reuseIdentifier) as! DropdownTCell
//        let indx = indexPath.row
//
//        cell.optionLabel.text = General.sharedInstance.genderTitles[indx]
//        cell.img.image = UIImage(named: General.sharedInstance.gendeImgs[indx])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 38
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        table.isHidden = true
//        btnGendeTypesMenue.setTitle(General.sharedInstance.genderTitles[indexPath.row], for: .normal)
//        imgeGender.image = UIImage(named: General.sharedInstance.gendeImgs[indexPath.row])
//        
//        selectedGenderId = General.sharedInstance.genderTitles[indexPath.row].integer
//    }
//    
//}
