//
//  SelectGenderVC+CollectionDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension SelectCategoriesVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCollection(){
        categoriesCollection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: (LanguageManager.shared.isRightToLeft ? .right: .left), verticalAlignment: .top)
        alignedFlowLayout.minimumLineSpacing = 5
        alignedFlowLayout.minimumInteritemSpacing = 5
        categoriesCollection.collectionViewLayout = alignedFlowLayout
        
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.reloadData()        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell

        cell.lblTitle.text = categories?[indexPath.row].name ?? ""
        cell.img.loadImage(path:  categories?[indexPath.row].icon ?? "")
        cell.btnDelete.isHidden = true
        if selectionArray[indexPath.row] == true
        {//selected
            cell.lblTitle.textColor = Colors.PrimaryColor
            cell.bgView.borderColor = Colors.PrimaryColor
            cell.bgView.backgroundColor = Colors.lightGray
        }else{
            //unselect
            cell.lblTitle.textColor = Colors.textColor
            cell.bgView.borderColor = Colors.lightGray
            cell.bgView.backgroundColor = .clear
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionArray[indexPath.row] = !selectionArray[indexPath.row]
        
        if selectionArray[indexPath.row] == true{
            selectedCatId.append((categories?[indexPath.row].id)!)
        }else{
            selectedCatId.removeAll(where: { $0 == categories?[indexPath.row].id })
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = categories?[indexPath.row].name ?? ""
        let cellStringFont = UIFont(name:"DIN Next LT W23 Regular", size: 18)!
        let cellStringFont1 = FontManager.fontWithSize(size: 18)
        // must be the same with cell label font in xib
        let size: CGSize = name.size(withAttributes: [
            NSAttributedString.Key.font: cellStringFont
        ])

        return CGSize(width: size.width + 66, height: 46)
        
    }
    

    
}

