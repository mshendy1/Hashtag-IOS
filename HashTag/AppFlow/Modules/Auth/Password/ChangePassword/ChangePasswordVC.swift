//
//  ChagePasswordVC.swift
//  HashTag
//
//  Created by Mohamed Shendy on 06/02/2023.
//

import UIKit
protocol ChangePasswordDelegate {
    func dismissChangePassword()
}
class ChangePasswordVC: UIViewController {
    @IBOutlet weak var btnSecureOldPassword:UIButton!
    @IBOutlet weak var btnSecureNewPassword:UIButton!
    @IBOutlet weak var btnSecureConfirmPassword:UIButton!
    @IBOutlet weak var tfOldPassword:UITextField!
    @IBOutlet weak var tfNewPassword:UITextField!
    @IBOutlet weak var tfConfirmPassword:UITextField!
    
    var delegate: ChangePasswordDelegate?
    //var phone:String?
   // var changePasswordVM:ChangePasswordViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }



}





