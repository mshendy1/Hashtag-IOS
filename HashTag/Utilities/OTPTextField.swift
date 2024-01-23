//
//  OTPTextField.swift
//  SHAHM
//
//  Created by Mohamed Shendy on 02/01/2023.
//

import Foundation
import UIKit
class OTPTextField: UITextField {
  weak var previousTextField: OTPTextField?
  weak var nextTextField: OTPTextField?
  override public func deleteBackward(){
    text = "-"
    previousTextField?.becomeFirstResponder()
   }
}
