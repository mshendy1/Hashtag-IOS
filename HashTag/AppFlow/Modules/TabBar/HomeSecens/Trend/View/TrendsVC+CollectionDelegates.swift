//
//  TrendsVC+CollectionDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 13/03/1445 AH.
//


import Foundation
import UIKit
import LanguageManager_iOS


extension TrendsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    func setupTrendCollection(){
        trendCollection.register(UINib(nibName: "\(TrendSectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TrendSectionCell.self)")
        trendCollection.delegate = self
        trendCollection.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

           let cell = trendCollection.dequeueReusableCell(withReuseIdentifier: "\(TrendSectionCell.self)", for: indexPath) as! TrendSectionCell
            
            cell.lblTitle.text = General.sharedInstance.trendTitles[indexPath.row]
//            (selectedType == .twitter && indexPath.row == 3 ) ||
            if  (selectedTrendType == .youtube && indexPath.row == 2) || (selectedTrendType == .google && indexPath.row == 1) || (selectedTrendType == .googleNews && indexPath.row == 0)
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (trendCollection.frame.width / 3)
            return CGSize(width: width , height: width - 10)
        }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch indexPath.row{
           // case 3:selectedType = .twitter
            case 2:
                selectedTrendType = .youtube
                trendVM?.callGetTrendsYoutubeApi()

            case 1:
                selectedTrendType = .google
                trendVM?.callGetTrendsGoogleApi()
            case 0:
                selectedTrendType = .googleNews
                trendVM?.callGetTrendsNewsApi()

            default:
                break
            }


    }
    
}



