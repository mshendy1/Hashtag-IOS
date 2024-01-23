//
//  CustomButton.swift
//  SHAHM
//
//  Created by Mohamed Shendy on 30/12/2022.
//

import Foundation
import UIKit

@IBDesignable
class UICustomButton: UIButton {

    // button corner radius
    @IBInspectable override var cornerRadius: CGFloat  {
        didSet {
           self.layer.cornerRadius = cornerRadius
        }
    }
    // button border colors
    @IBInspectable var borderColors: UIColor = UIColor.clear {
        didSet {
           self.layer.borderColor = borderColors.cgColor
        }
    }
    // button border width
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
           self.layer.borderWidth = borderWidth
        }
    }

    // button shadow color
    @IBInspectable override var shadowColor: UIColor {
       didSet{
          self.layer.shadowColor = shadowColor.cgColor
          self.layer.masksToBounds = false
       }
    }
    // button shadow opacity
    @IBInspectable override var shadowOpacity: Float{
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowOpacity = shadowOpacity
       }
    }

    // button shadow offset
    @IBInspectable override var shadowOffset: CGSize {
        didSet {
           self.layer.masksToBounds = false
           self.layer.shadowOffset = shadowOffset
        }
    }
    // button shadow radius
    @IBInspectable override var shadowRadius: CGFloat {
       didSet {
          self.layer.masksToBounds = false
          self.layer.shadowRadius = shadowRadius
       }
    }

    public override class var layerClass: AnyClass {
           CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
            layer as! CAGradientLayer
    }
    // button start color gradient
    @IBInspectable public var startColor: UIColor = .white {
        didSet {
           updateColors()
        }
    }

    // button end color gradient
    @IBInspectable public var endColor: UIColor = .red {
       didSet {
          updateColors()
       }
    }

    // button start point gradient
    @IBInspectable public var startPoint: CGPoint {
        get {
            gradientLayer.startPoint
        }

        set {
            gradientLayer.startPoint = newValue
        }
     }

     // button end point gradient
     @IBInspectable public var endPoint: CGPoint {
        get {
            gradientLayer.endPoint
        }
        set {
            gradientLayer.endPoint = newValue
        }
     }

     // update colores gradient
     private func updateColors() {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
     }



}


