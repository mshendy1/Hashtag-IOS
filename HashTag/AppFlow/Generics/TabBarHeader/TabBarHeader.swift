//
//  TabBarHeader.swift
//  BasetaApp
//
//  Created by Mohamed Shendy on 2/5/22.
//

import UIKit

protocol TabBarHeaderDelegate : AnyObject {
    func openSearch()
}

final class TabBarHeader: UIView {
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var view: UIView!
    private static let nibName = "TabBarHeader"
    var delegate:TabBarHeaderDelegate?
    
    override func awakeFromNib(){
        initFromNib()
    }
    
 
    private func initFromNib(){
        Bundle.main.loadNibNamed(TabBarHeader.nibName, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
//        viewX.addShadow_(parentview: viewX)
        setupLayout()
        
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        delegate?.openSearch()
    }
    
  
}
