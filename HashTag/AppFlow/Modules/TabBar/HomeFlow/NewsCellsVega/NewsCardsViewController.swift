//
//  NewsVega.swift
//  HashTag
//
//  Created by Trend-HuB on 30/11/1444 AH.
//

import UIKit
import VerticalCardSwiper

class NewsCardsViewController: UIViewController {
    
    @IBOutlet private var cardSwiper: VerticalCardSwiper!
    @IBOutlet weak var header:AuthNavigation!
    var NewsCardsVM:NewsCardsViewModel?
    var allPostsPage = 1
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsCardsVM = NewsCardsViewModel(delegate: self)
        setupCollection()
        header.delegate = self
        header.delegate = self
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        header.lblTitle.text = Constants.PagesTitles.postsTitle
        setupCollection()
        NewsCardsVM?.callGetPostsApi(category_id:[], tag_id: [], page: allPostsPage)
    }
 

}

extension NewsCardsViewController:VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
   
    
    func cardDisplay(verticalCardSwiperView: VerticalCardSwiperView, willDisplay cell: CardCell, forItemAt index: IndexPath) {
        
    }
    
   

    
    
    
    func setupCollection(){
        cardSwiper.register(nib: UINib(nibName: "NewsCardsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCardsCell")
        cardSwiper.isSideSwipingEnabled = false
        cardSwiper.delegate = self
        cardSwiper.datasource = self
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return NewsCardsVM?.postsArray?.count ?? 0
       }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "NewsCardsCell", for: index) as? NewsCardsCell {
            let index = NewsCardsVM?.postsArray?[index]
            cardCell.configPostCardsCell(posts: index)
            return cardCell
        }
        return CardCell()
    }
        
    func sizeForItem(verticalCardSwiperView: VerticalCardSwiperView, index: Int) -> CGSize {
     
         // Allows you to return custom card sizes (optional).
         return CGSize(width: verticalCardSwiperView.frame.width , height: verticalCardSwiperView.frame.height)
     }
    
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
    }

    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }
    
    
        
    }
extension NewsCardsViewController:AuthNavigationDelegate{
    func turAction() {}
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewsCardsViewController:NewsCardsViewModelDelegate{
    func showLoading(){startLoadingIndicator() }
    func killLoading() {stopLoadingIndicator()}
    func connectionFailed() {showNoInternetAlert()}
    func showError(error: String){showErrorNativeAlert(message: error)}
    func reloadPosts(){ cardSwiper.reloadData()}
}



extension NewsCardsViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            if position > (cardSwiper.verticalCardSwiperView.contentSize.height - 100 -  scrollView.frame.size.height){
                // fetch more data
                guard !NewsCardsVM!.postsIsPagination else {
                    // we already fateching  more data
                    return
                }
                
                if (NewsCardsVM?.lastPageForPosts ?? 1) >= (allPostsPage + 1){
                    allPostsPage += 1
                    print("allPostsPage \(allPostsPage)")
                    let spinner = UIActivityIndicatorView(style:.medium)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: cardSwiper.bounds.width, height: CGFloat(44))
                    spinner.color = .black
                    
                    // call api again
                    NewsCardsVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)
                }else
                {
                    //mean we call last page and don't call api again
                }
            }

        
    }
}
