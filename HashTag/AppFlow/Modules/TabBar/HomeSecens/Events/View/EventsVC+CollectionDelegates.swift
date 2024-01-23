//
//  EventsVC+CategoriesDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 13/03/1445 AH.
//

import Foundation
import UIKit
import LanguageManager_iOS


//extension EventsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    
//    func setupCollection(){
//        categoriesCollection.register(UINib(nibName: "\(CategoriesCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoriesCell.self)")
//        categoriesCollection.delegate = self
//        categoriesCollection.dataSource = self
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return General.sharedInstance.selectedCategories.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "\(CategoriesCell.self)", for: indexPath) as! CategoriesCell
//            
//            cell.lblTitle.text = General.sharedInstance.selectedCategories[indexPath.row].name ?? ""
//            cell.lblTitle.textColor = Colors.PrimaryColor
//            cell.img.image = UIImage(named: "remove")
//            cell.btnDelete.tag = indexPath.row
//            cell.btnDelete.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
//
//            cell.bgView.backgroundColor = Colors.bgColor
//            cell.borderWidth = 0
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let name = General.sharedInstance.selectedCategories[indexPath.row].name ?? ""
//            let cellStringFont = FontManager.fontWithSize(size: 10)
//            // must be the same with cell label font in xib
//            let size: CGSize = name.size(withAttributes: [
//                NSAttributedString.Key.font: cellStringFont
//            ])
//            return CGSize(width: size.width + 40, height: 40)
//            
//        }
//    
//    
//    
//    
//
//    
//}


