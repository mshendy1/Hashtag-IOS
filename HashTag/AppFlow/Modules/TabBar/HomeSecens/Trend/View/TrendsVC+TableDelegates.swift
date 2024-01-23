

//  tableViewDelegate.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import UIKit

extension TrendsVC:UITableViewDelegate,UITableViewDataSource {
  
    
    
    func setupTableVC(){
        //MARK:- Trend Cells
        table.register(UINib(nibName: YoutubeCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: YoutubeCell.reuseIdentifier)
        
        table.register(UINib(nibName: TwitterCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TwitterCell.reuseIdentifier)
        
        table.register(UINib(nibName: TrendGoogleNewsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TrendGoogleNewsCell.reuseIdentifier)
       

        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.separatorColor = .clear
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // tableView ==  table
            switch self.selectedTrendType{
            case .twitter:
                return trendVM?.trendTwitterArray?.count ?? 0
            case .youtube:
                return trendVM?.trendYoutubeArray?.count ?? 0
            case .google:
                return trendVM?.trendGoogleArray?.count ?? 0
            case .googleNews:
                return trendVM?.trendGoogleNewsArray?.count ?? 0
            case .none:
                break
            }
            return 0
        }
    
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch self.selectedTrendType{
    case .twitter:
        let cell = tableView.dequeueReusableCell(withIdentifier:TwitterCell.reuseIdentifier) as! TwitterCell
        if indexPath.row == 0
        {
            cell.lineLbl.isHidden = true
        }else
        {
            cell.lineLbl.isHidden = false
        }
        let index = indexPath.row
        cell.configTwitterCell(model: trendVM?.trendTwitterArray?[index])
        cell.lblNum.text = "\(indexPath.row + 1)"
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    case .youtube:
        let cell = tableView.dequeueReusableCell(withIdentifier:YoutubeCell.reuseIdentifier) as! YoutubeCell
        let index = indexPath.row
        cell.configCellWithModel(model: trendVM?.trendYoutubeArray?[index])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    case .google:
        let cell = tableView.dequeueReusableCell(withIdentifier:TwitterCell.reuseIdentifier) as! TwitterCell
        cell.lblNum.text = "\(indexPath.row + 1)"
        let index = indexPath.row
        cell.configeNewsCell(model: trendVM?.trendGoogleArray?[index])
        if indexPath.row == 0
        {
            cell.lineLbl.isHidden = true
        }else
        {
            cell.lineLbl.isHidden = false
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    case .googleNews:
        let cell = tableView.dequeueReusableCell(withIdentifier:TrendGoogleNewsCell.reuseIdentifier) as! TrendGoogleNewsCell
        let index = indexPath.row
        cell.configCell(model: trendVM?.trendGoogleNewsArray?[index])
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    case .none:
        break
    }
    return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
            switch self.selectedTrendType{
            case .twitter:
                return General.sharedInstance.twitterTableCellHeight
            case .youtube:
                return General.sharedInstance.youtubeTableCellHeight
            case .google:
                return General.sharedInstance.twitterTableCellHeight
            case .googleNews:
                return General.sharedInstance.googleNewsTableCellHeight
            case .none:
                break
            }
            return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            switch self.selectedTrendType{
            case .twitter:
                let twitterKeyword = trendVM?.trendTwitterArray?[indexPath.row]?.query ?? ""
                trendVM?.delegate?.trendTwitterTapped(tex: twitterKeyword)
                return
            case .youtube:
                let indexUrl = trendVM?.trendYoutubeArray?[indexPath.row]?.url ?? ""
                trendVM?.delegate?.youtubeTapped(url: indexUrl)
                return
            case .google:
                let indexUrl = trendVM?.trendGoogleArray?[indexPath.row]?.title ?? ""
                trendVM?.delegate?.trendGoogleTapped(url: indexUrl)
                return
            case .googleNews:
                let indexUrl = trendVM?.trendGoogleNewsArray?[indexPath.row]?.url ?? ""
                trendVM?.delegate?.trendGoogleNewsTapped(url: indexUrl)
                return
            case .none:
                break
            }
    }
    
    
    
}
