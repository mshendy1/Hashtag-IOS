//
//  File.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import UIKit
import LanguageManager_iOS


extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCategoriesCollection(){
        homeCategoriesCollection.register(UINib(nibName: "\(CategoriesCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoriesCell.self)")
        homeCategoriesCollection.delegate = self
        homeCategoriesCollection.dataSource = self
       // homeCategoriesCollection.reloadData()
    }
    
    func setupTrendCollection(){
        trendCollection.register(UINib(nibName: "\(TrendSectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TrendSectionCell.self)")
        trendCollection.delegate = self
        trendCollection.dataSource = self
        //trendCollection.reloadData()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendCollection {
            return 3
        }else{
            return General.sharedInstance.selectedCategories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == trendCollection {
           let cell = trendCollection.dequeueReusableCell(withReuseIdentifier: "\(TrendSectionCell.self)", for: indexPath) as! TrendSectionCell
            
            cell.lblTitle.text = General.sharedInstance.trendTitles[indexPath.row]
//            (selectedType == .twitter && indexPath.row == 3 ) ||
            if  (selectedType == .youtube && indexPath.row == 2) || (selectedType == .google && indexPath.row == 1) || (selectedType == .googleNews && indexPath.row == 0)
            {
                cell.img.image = UIImage.init(named: General.sharedInstance.selecteimgs[indexPath.row])
                cell.lblTitle.textColor = Colors.Black
                cell.viewBG.backgroundColor = Colors.bgColor
                cell.lblTitle.font = FontManager.font(withSize: 16,style: .medium)
            }
        else
            {
            cell.img.image = UIImage.init(named: General.sharedInstance.Unselecteimgs[indexPath.row])
            cell.lblTitle.textColor = Colors.textColor

            cell.viewBG.backgroundColor = .white
            cell.lblTitle.font = FontManager.font(withSize: 14,style: .regular)
        }
            return cell
        }else{
            let cell = homeCategoriesCollection.dequeueReusableCell(withReuseIdentifier: "\(CategoriesCell.self)", for: indexPath) as! CategoriesCell
            
            cell.lblTitle.text = General.sharedInstance.selectedCategories[indexPath.row].name ?? ""
            cell.lblTitle.textColor = Colors.PrimaryColor
            cell.img.image = UIImage(named: "remove")
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)

            cell.bgView.backgroundColor = Colors.bgColor
            cell.borderWidth = 0
            if LanguageManager.shared.isRightToLeft
            {
                //cell.contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        return cell

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == trendCollection{
            let width = (trendCollection.frame.width / 3)
            return CGSize(width: width , height: width - 10)
        }else{
            let name = General.sharedInstance.selectedCategories[indexPath.row].name ?? ""
            let cellStringFont = FontManager.fontWithSize(size: 10)
            // must be the same with cell label font in xib
            let size: CGSize = name.size(withAttributes: [
                NSAttributedString.Key.font: cellStringFont
            ])
            return CGSize(width: size.width + 40, height: 40)
        }
            
        }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trendCollection {
            switch indexPath.row{
           // case 3:selectedType = .twitter
            case 2:selectedType = .youtube
            case 1:selectedType = .google
            case 0:selectedType = .googleNews

            default:
                break
            }
            trendCollection.reloadData()
            table.reloadData()
            handelTableHeight()
            
        }else{
        }
        
    }
    
    
    @objc func deleteItem(_ sender :UIButton){
        let index = sender.tag
        General.sharedInstance.selectedCategories.remove(at: index)
        General.sharedInstance.selectedCatId.remove(at: index)

        homeCategoriesCollection.reloadData()
        
        homeVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)

    }
    
    

    
}



