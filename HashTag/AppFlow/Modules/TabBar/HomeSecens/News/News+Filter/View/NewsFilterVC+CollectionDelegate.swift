//
//  FilterVC+CollectionDelegate.swift
//  HashTag
//
//  Created by Eman Gaber on 21/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension NewsFilterVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCategoryCollection(){
        categoriesCollection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
      
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: (LanguageManager.shared.isRightToLeft ? .right: .left), verticalAlignment: .top )
        
        categoriesCollectionHeight.constant = categoriesCollection.fs_height + 30
        print(categoriesCollection.fs_height )
        
        viewHeight.constant += (categoriesCollectionHeight.constant) - 200
        categoriesCollection.collectionViewLayout = alignedFlowLayout
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.reloadData()
    }
    
   func setupTagsCollection(){
       tagsCollection.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")

       tagsCollection.delegate = self
       tagsCollection.dataSource = self
       tagsCollection.reloadData()
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollection {
            return categories?.count ?? 0
        }else{
            return tags?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell

            cell.lblTitle.text = categories?[indexPath.row].name ?? ""
            cell.img.loadImage(path: categories?[indexPath.row].icon ?? "")
            cell.btnDelete.isHidden = true
            if selectionCatArray[indexPath.row] == true
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
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell

            cell.lblTitle.text = tags?[indexPath.row].name ?? ""
            if selectionTagsArray[indexPath.row] == true
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
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == categoriesCollection{
            selectionCatArray[indexPath.row] = !selectionCatArray[indexPath.row]
            
            if selectionCatArray[indexPath.row] == true
            {
                selectedCatId.append((categories?[indexPath.row].id)!)
                selectedCategories.append((categories?[indexPath.row])!)
            }else
            {
                selectedCatId.removeAll(where: { $0 == categories?[indexPath.row].id })
                selectedCategories.removeAll(where: { $0.id == categories?[indexPath.row].id })
            }
            collectionView.reloadData()

        }else{
            selectionTagsArray[indexPath.row] = !selectionTagsArray[indexPath.row]
            
            if selectionTagsArray[indexPath.row] == true
            {
                selectedTagsId.append((tags?[indexPath.row].id)!)
                selectedTags.append((tags?[indexPath.row])!)
            }else
            {
                selectedTagsId.removeAll(where: { $0 == tags?[indexPath.row].id })
                selectedTags.removeAll(where: { $0.id == tags?[indexPath.row].id })
            }
            collectionView.reloadData()

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var name = ""
        if collectionView == tagsCollection {
             name = tags?[indexPath.row].name ?? ""
        }else{
            name = categories?[indexPath.row].name ?? ""
        }
        let cellStringFont = UIFont(name:"DIN Next LT W23 Regular", size: 18)!
       //  must be the same with cell label font in xib
        let size: CGSize = name.size(withAttributes: [
            NSAttributedString.Key.font: cellStringFont
        ])
        return CGSize(width: size.width + 60, height: 40)

    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    

}