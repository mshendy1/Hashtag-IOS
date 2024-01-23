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

protocol LoginHeaderDelegate:AnyObject {
    func Skip()
}

final class LoginHeader: UIView {
    
    private static let NIB_NAME = "LoginHeader"
    @IBOutlet  var view: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var img: UIImageView!

    var delegate : LoginHeaderDelegate?

    override func awakeFromNib() {
        initWithNib()
       // btnBack.setTitle("Skip".localiz(), for: .normal)

    }
    
    
    private func initWithNib() {
        
        Bundle.main.loadNibNamed(LoginHeader.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()

    }
    
    @IBAction func backTapped(){
        delegate?.Skip()
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
