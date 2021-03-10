//
//  TripsViewController.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import UIKit

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate {

    var tripStore : TripStore!
    
    var newTripViewController = NewTripViewController()
    var detailViewController = DetailViewController()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditingModel))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddSegue"?:
            newTripViewController = segue.destination as! NewTripViewController
            newTripViewController.tripStore = tripStore
            newTripViewController.isVisible = true
        case "DetailSegue"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let trip = tripStore.allTrips[row]
                
                detailViewController = segue.destination as! DetailViewController
                detailViewController.trip = trip
                detailViewController.isVisible = true
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripStore.allTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
        let trip = tripStore.allTrips[indexPath.row]
        
        cell.sourceLabel?.text = trip.source
        cell.destinationLabel?.text = trip.destination
        cell.gasInLiterLabel?.text = trip.metric
        
        return cell
    }
    
    @objc func toggleEditingModel(sender: UIBarButtonItem) {
        if tableView.isEditing {
            sender.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            tableView.setEditing(true, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let trip = tripStore.allTrips[indexPath.row]
            
            let title = "Delete \(trip.source) to \(trip.destination)?"
            let message = "Are you sure you want to delete this trip?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) -> Void in self.tripStore.removeTrip(trip)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tripStore.moveTrip(from: sourceIndexPath.row, to:destinationIndexPath.row)
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        var result : Bool = true
        
        if newTripViewController.isVisible {
            result = newTripViewController.validateData()
        } else if detailViewController.isVisible {
            result = detailViewController.validateData()
        }
        
        
        if (result) {
            // remove its child view controller that is a newTripViewController object
            navigationController?.popViewController(animated: true)
            newTripViewController.isVisible = false
            detailViewController.isVisible = false
        }

        return result
    }
    
    // number formatter
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

}
