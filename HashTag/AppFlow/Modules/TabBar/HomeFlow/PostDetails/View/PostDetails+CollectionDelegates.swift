//
//  PostDetails+CollectionDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 02/08/1444 AH.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension PostDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCollection(){
        tagsCollection.register(UINib(nibName: "\(CategoriesCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoriesCell.self)")
        tagsCollection.delegate = self
        tagsCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postDetailsVM?.tagsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoriesCell.self)", for: indexPath) as! CategoriesCell
        
        cell.viewDelete.isHidden = true
        let index = postDetailsVM.tagsArray?[indexPath.row]
        cell.lblTitle.text = index?.name ?? ""
        cell.lblTitle.textColor = Colors.PrimaryColor
        cell.img.image = UIImage(named:"remove")
        cell.bgView.backgroundColor = .white
        cell.borderWidth = 0
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = postDetailsVM.tagsArray?[indexPath.row]
        let name = index?.name ?? ""
        let cellStringFont = FontManager.fontWithSize(size: 18)
        
        //UIFont(name:"DIN Next LT W23 Regular", size: 18)!
       // let cellStringFont1 = FontManager.fontWithSize(size: 18)
        // must be the same with cell label font in xib
        let size: CGSize = name.size(withAttributes: [
            NSAttributedString.Key.font: cellStringFont
        ])
        return CGSize(width: size.width + 66, height: 38)
    
}
  
    
   

    
}

