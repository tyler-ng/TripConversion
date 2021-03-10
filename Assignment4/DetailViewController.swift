//
//  DetailViewController.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    var trip: Trip!
    var isVisible: Bool = false
   
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var sourceField: UITextField!
    @IBOutlet weak var gasField: UITextField!
    @IBOutlet weak var valMsgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationField.delegate = self
        sourceField.delegate = self
        gasField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sourceField.text = trip.source
        destinationField.text = trip.destination
        gasField.text = trip.metric
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        trip.source = sourceField.text ?? ""
        trip.destination = destinationField.text ?? ""
        let gasText = gasField.text!.replacingOccurrences(of: ",", with: "")
        let gasInDouble = Double(gasText)
        let gasInStr = numberFormatter.string(from: NSNumber(value: gasInDouble!))
        
        trip.metric = gasInStr!
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // check validation
    func validateData() -> Bool {
        let emptyMsg = "Please enter data"
        if sourceField.text!.isEmpty {
            valMsgLabel.text = emptyMsg
            return false
        }
        if destinationField.text!.isEmpty {
            valMsgLabel.text = emptyMsg
            return false
        }
        
        if gasField.text!.isEmpty {
            valMsgLabel.text = emptyMsg
            return false
        }
        
        if Double(gasField.text!) == nil {
              valMsgLabel.text = "Gas number is not correct"
              return false
        }
        
        return true
        
    }
    
}
