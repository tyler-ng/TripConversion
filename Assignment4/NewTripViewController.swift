//
//  NewTripViewController.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController, UITextFieldDelegate {

    var tripStore: TripStore!
    var validated: Bool = false
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
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        let trip: Trip = Trip()
        
        trip.destination = destinationField.text ?? ""
        trip.source = sourceField.text ?? ""
        
        
        if let gasInDouble = Double(gasField.text!) {
            let gasInGal = Measurement(value: gasInDouble, unit: UnitVolume.gallons)
            let gasInLiter = gasInGal.converted(to: .liters)
            let gasInStr = numberFormatter.string(from: NSNumber(value: gasInLiter.value))

            trip.metric = gasInStr!
        }
        
        tripStore.allTrips.append(trip)
        
    }
    
    // number formatter
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
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
