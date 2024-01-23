//
//  SelectGenderVC+CollectionDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import Foundation
import UIKit


extension SelectGenderViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCollection(){
        genderCollection.register(UINib(nibName: "GenderCell", bundle: nil), forCellWithReuseIdentifier: "GenderCell")
        
        genderCollection.delegate = self
        genderCollection.dataSource = self
        genderCollection.reloadData()
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderCell", for: indexPath) as! GenderCell
        if indexPath.row == 1{
            cell.lblTitle.text = "Male".localiz()
            cell.img.image  = UIImage(named: "male")


        }else{
            cell.lblTitle.text = "Female".localiz()
            cell.img.image  = UIImage(named: "female")

        }
        
        if selectionIndex == indexPath.row
        {
            cell.lblTitle.textColor = Colors.Black
            cell.checkBox.tintColor = Colors.PrimaryColor
            cell.checkBox.image = UIImage.init(systemName: "checkmark.circle.fill")
            cell.bgView.borderColor = Colors.PrimaryColor
            cell.bgView.backgroundColor = Colors.lightGray
        }else{
            cell.lblTitle.textColor = Colors.textColor
            cell.checkBox.tintColor = Colors.lightGray
            cell.checkBox.image = UIImage.init(systemName: "circle")
            cell.bgView.borderColor = Colors.lightGray
            cell.bgView.backgroundColor = .clear
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionIndex = indexPath.row
        
        if indexPath.row == 0
        {
            genderId = 2 // female
        }else{
            genderId = 1 //male
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 5
        print(width)
        return CGSize(width: width, height:140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}

