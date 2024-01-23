//
//  NavigationBar.swift
//  medexa
//
//  Created by Mohamed Shendy on 19/11/21.
//  Copyright © 2021 Mohamed Shendyaber. All rights reserved.
//

import Foundation
import UIKit


protocol IntroNavigationDelegate:AnyObject {
    func skip()
}

final class IntroNavigation: UIView {
    
    private static let NIB_NAME = "IntroNavigation"
    @IBOutlet  var view: UIView!
    @IBOutlet weak var btnSkip: UIButton!

    var delegate : IntroNavigationDelegate?
    
    override func awakeFromNib() {
        initWithNib()
        btnSkip.setTitle("Skip".localiz(), for: .normal)
    }
    private func initWithNib() {
        Bundle.main.loadNibNamed(IntroNavigation.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [ view.topAnchor.constraint(equalTo: topAnchor),
              view.leadingAnchor.constraint(equalTo: leadingAnchor),
              view.bottomAnchor.constraint(equalTo: bottomAnchor),
               view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    @IBAction func skipAction(){
        delegate?.skip()
    }
}
