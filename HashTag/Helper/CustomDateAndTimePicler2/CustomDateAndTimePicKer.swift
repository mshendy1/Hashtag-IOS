//
//  CustomDateAndTimePicKer.swift
//  SAR
//
//  Created by Tariq Al-aqrabawi on 16/08/2021.
//  Copyright © 2021 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit

class CustomDateAndTimePicKer: UIView {
    
    static let instance = CustomDateAndTimePicKer()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    fileprivate var yesCompletion : ((String) -> ())? = {_ in return}
    //var complection : (_ object:SetData) -> ()? = {_ in return}
    
    
    var date = Date()
    var selectedDate = String()
    var fromPage = 0 // 1 is for passenger details
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomDateAndTimePicKer", owner: self, options: nil)
        commonInit()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
    }
    
    func showAlert(){
        setupView(min: Date() , max: Date(),current: Date())
    }
    

    func setupView(min:Date,max:Date,current:Date){
        cancelButton.setTitle("Cancel".localiz(), for: .normal)
        okButton.setTitle("OK".localiz(), for: .normal)
        dateView.layer.cornerRadius = 10
        dateView.clipsToBounds = true
        datePicker.minimumDate = min
        datePicker.timeZone = TimeZone.current //eman //TimeZone(secondsFromGMT: 0)
        datePicker.maximumDate = max
        datePicker.date = current
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }

        
        self.parentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        animateView()
    }
    
    func setupView1(min:Date,max:Date){
        cancelButton.setTitle("Cancel".localiz(), for: .normal)
        okButton.setTitle("OK".localiz(), for: .normal)
        dateView.layer.cornerRadius = 10
        dateView.clipsToBounds = true
        datePicker.minimumDate = min
        datePicker.timeZone = TimeZone.current
        datePicker.date = date
        
        
        datePicker.datePickerMode = .dateAndTime
        
      //
        if #available(iOS 13.4, *) {
            //      datePicker.preferredDatePickerStyle = .compact
            if #available(iOS 14.0, *) {
                datePicker.preferredDatePickerStyle = .inline
            } else {
                datePicker.preferredDatePickerStyle = .compact
            }
        } else {
            // Fallback on earlier versions
        }
        self.parentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        animateView()
    }
    
    
    func returnEventDate(max: Date = Date(),min:Date = Date(),selectedDate: @escaping (_ stringDate:String) -> ()){
        self.setupView(min: min, max: max, current: Date())
        datePicker.date = date
        datePicker.datePickerMode = .dateAndTime


        self.yesCompletion = selectedDate
    }
    

    
    func animateView() {
        parentView.alpha = 0;
        self.parentView.frame.origin.y = self.parentView.frame.origin.y + 50
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.parentView.alpha = 1.0;
            self.parentView.frame.origin.y = self.parentView.frame.origin.y - 50
            UIApplication.shared.keyWindow?.addSubview(self.parentView)
            
        })
    }
    
    @IBAction func datePickerData(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        formatter.locale = Locale(identifier: "en_US")
        self.date = datePicker.date
        let seDate = formatter.string(from: datePicker.date)
        self.selectedDate  = seDate
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        UIView.transition(with: self.parentView, duration: 0.3, options: [.beginFromCurrentState], animations: {
            self.parentView.removeFromSuperview()
        }, completion: nil)
    }
    
    @IBAction func selectedButtonDate(_ sender: UIButton) {
        if let completion = self.yesCompletion {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            if self.selectedDate == "" {
                
                formatter.dateFormat = "yyyy-MM-dd"
                completion(formatter.string(from: datePicker.date))
            }else{
                completion(self.selectedDate)
            }
            self.parentView.removeFromSuperview()
            
            selectedDate = ""
        }
    }
    
}
