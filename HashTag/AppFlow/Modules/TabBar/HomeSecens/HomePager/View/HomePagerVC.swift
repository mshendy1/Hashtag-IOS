//
//  HomePagerVC.swift
//  HashTag
//
//  Created by Trend-HuB on 11/03/1445 AH.
//



import Foundation
import UIKit

protocol HomepagerVMDelegates: AnyObject {
    func moveToPostDetails(id: Int)
    func moveToPollDetails(id: Int)
    func moveToEventDetails(id:Int)
}
class HomePagerVC:UIViewController,LZViewPagerDelegate,LZViewPagerDataSource{
    @IBOutlet weak var header:TabBarHeader!
    @IBOutlet weak var ViewPager: LZViewPager!
    
    private var subControlles:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPagerProperties()
    }
    
    func viewPagerProperties(){
        ViewPager.delegate = self
        ViewPager.dataSource = self
        ViewPager.hostController = self
        header.delegate = self
        if !UserDefaults.standard.isLoggedIn(){
            header.lblUserName.isHidden = true
        }else if General.sharedInstance.socialLoginType == Constants.appWords.apple {
            header.lblUserName.text = KeychainItem.currentUserName
        }else{
            let name = UserData.shared.userDetails?.name ?? ""
            header.lblUserName.text = name
        }
        
        
        let apnsUserInfo = UserDefaults.standard.getUserInfo()
        print(apnsUserInfo)
       if apnsUserInfo.isEmpty == false {
           let type = apnsUserInfo["type"] as! String
           let id = apnsUserInfo["id"] as! String
           if type == "news"{
                   moveToPostDetails(id: Int(id) ?? 0)
           }else if type == "event"{
                   moveToEventDetails(id: Int(id) ?? 0)
           }else{
                   moveToPollDetails(id: Int(id) ?? 0)
           }
           UserDefaults.standard.removeObject(forKey:UserDefaultsKeys.userInfo.rawValue)
       }
        let news = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        let trends = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TrendsVC") as! TrendsVC
        let events = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
        let polls = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "PollsVC") as! PollsVC

        
        news.title = "news".localiz()
        trends.title = "trend".localiz()
        events.title = "events".localiz()
        polls.title = "surveys".localiz()

        subControlles = [news,trends,events,polls]
        ViewPager.reload()
        
    }
    
    func numberOfItems() -> Int {
        return self.subControlles.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControlles[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(Colors.Black, for: .normal)
        button.setTitleColor(Colors.PrimaryColor, for: UIControl.State.selected)
        button.titleLabel?.font = FontManager.font(withSize: 18, style: .medium)
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor{
        return Colors.PrimaryColor
    }
    
}

extension HomePagerVC:TabBarHeaderDelegate{
    func openSearch() {
        let vc = SearchVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


