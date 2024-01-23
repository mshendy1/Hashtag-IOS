//
//  homepagerViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/03/1445 AH.
//

import Foundation
import UIKit

extension HomePagerVC:HomepagerVMDelegates{
    
    func moveToPostDetails(id: Int) {
            let vc = PostDetailsVC()
            vc.postId = id
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToPollDetails(id: Int) {
            let vc = PollsDetailsVC()
            vc.surveyID = id
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToEventDetails(id:Int) {
        let vc = EventsDetailsVC()
        vc.eventId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
