//
//  ContactUs+CollectionDelegates.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
import UIKit

extension ContactUsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func setupCollection(){
        collection.register(UINib(nibName: "\(SocialCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SocialCell.self)")
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(SocialCell.self)", for: indexPath) as! SocialCell
        var index = indexPath.row
        var objc = ContactUsVM?.contactUsObjc

        switch index {
        case 0:
            if objc?.social?.facebook?.link != "" || objc?.social?.facebook?.link?.isValidURL == true {
                cell.img.loadImage(path: objc?.social?.facebook?.image ?? "")
            }else{
                cell.img.isHidden = true
            }
        case 1:
            if objc?.social?.instagram?.link != "" || objc?.social?.instagram?.link?.isValidURL == true {
                cell.img.loadImage(path: objc?.social?.instagram?.image ?? "")
            }else{
                cell.img.isHidden = true
            }
//        case 2:
//            if objc?.social?.linkedin?.link != "" || objc?.social?.linkedin?.link?.isValidURL == true {
//                cell.img.loadImage(path:objc?.social?.linkedin?.image ?? "")
//            }else{
//                cell.img.isHidden = true
//            }
        case 2:
                
            if objc?.social?.twitter?.link != "" || objc?.social?.twitter?.link?.isValidURL == true {
                cell.img.loadImage(path: objc?.social?.twitter?.image ?? "")            }else{
                cell.img.isHidden = true
            }
//        case 4:
//            if objc?.social?.tiktok?.link != "" || objc?.social?.tiktok?.link?.isValidURL == true {
//                cell.img.loadImage(path: objc?.social?.tiktok?.image ?? "")           }else{
//                cell.img.isHidden = true
//            }
        case 3:
            if objc?.social?.snapchat?.link != "" {
                cell.img.loadImage(path: objc?.social?.snapchat?.image ?? "")           }else{
                cell.img.isHidden = true
            }
        default: break
                
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let objc = ContactUsVM?.contactUsObjc

        switch index {
        case 0:
            guard (objc?.social?.facebook != nil) else {return}
            socialTapped(url: objc?.social?.facebook?.link ?? "")
        case 1:
            guard (objc?.social?.instagram != nil) else {return}
            socialTapped(url: objc?.social?.instagram?.link ?? "")
//        case 2:
//            guard (objc?.social?.linkedin != nil) else {return}
//            socialTapped(url: objc?.social?.linkedin?.link ?? "" )
        case 2:
            guard (objc?.social?.twitter != nil) else {return}
            socialTapped(url: objc?.social?.twitter?.link ?? "")
        case 3:
            guard (objc?.social?.snapchat != nil) else {return}
            socialTapped(url: objc?.social?.snapchat?.link ?? "")
        default: break
                
        }
        
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
