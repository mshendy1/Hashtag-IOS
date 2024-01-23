//
//  CreateEventVC+collectiondelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 22/09/1444 AH.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension CreateEventVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    func setupCollection(){
        collection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
      
       let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: (LanguageManager.shared.isRightToLeft ? .right: .left), verticalAlignment: .top )
        alignedFlowLayout.minimumLineSpacing = 5
        alignedFlowLayout.minimumInteritemSpacing = 5
        collection.collectionViewLayout = alignedFlowLayout
    
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return types?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        
            cell.lblTitle.text = types?[indexPath.row].name ?? ""
            cell.img.isHidden = true
            cell.btnDelete.isHidden = true
            if selectionTypesArray[indexPath.row] == true
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

            selectionTypesArray[indexPath.row] = !selectionTypesArray[indexPath.row]
            if selectionTypesArray[indexPath.row] == true
            {
                selectedId.append((types?[indexPath.row].id)!)
                selectedTypes.append((types?[indexPath.row])!)
            }else
            {
                selectedId.removeAll(where: { $0 == types?[indexPath.row].id })
                selectedTypes.removeAll(where: { $0.id == types?[indexPath.row].id })
            }
            collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var name = ""
            name = types?[indexPath.row].name ?? ""
        let cellStringFont = UIFont(name:"DIN Next LT W23 Regular", size: 16)!
        // must be the same with cell label font in xib
        let size: CGSize = name.size(withAttributes: [
            NSAttributedString.Key.font: cellStringFont
        ])
        return CGSize(width: size.width + 60, height: 40)

    }
    

    
}
