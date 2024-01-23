//
//  NavigationBar.swift
//  medexa
//
//  Created by Mohamed Shendy on 19/11/21.
//  Copyright © 2021 Mohamed Shendyaber. All rights reserved.
//

import Foundation
import UIKit
import LanguageManager_iOS

protocol AuthNavigationDelegate:AnyObject {
    func backAction()
    func turAction()
}

final class AuthNavigation: UIView {
    
    private static let NIB_NAME = "AuthNavigation"
    @IBOutlet  var view: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var switchNotificattion: UISwitch!

    var delegate : AuthNavigationDelegate?

    override func awakeFromNib() {
        initWithNib()

    }
    
    
    private func initWithNib() {
        
        Bundle.main.loadNibNamed(AuthNavigation.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()

    }
    
    @IBAction func backTapped(){
        delegate?.backAction()
    }
    
    @IBAction func turnTapped(){
        delegate?.turAction()
       
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
}
