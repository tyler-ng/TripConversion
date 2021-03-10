//
//  TripStore.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import Foundation

class TripStore {
    var allTrips = [Trip]()
    
    let tripArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("trips.archive")
    }()
    
    // init trips from background
    init() {
        do {
            if let data = UserDefaults.standard.data(forKey: "SavedItems") {
                let tripArchiveTrips = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Trip.self], from: data) as? [Trip]
                self.allTrips = tripArchiveTrips!
            } else {
                print("Data does not exist in defaults")
            }
        } catch {
            print("unarchiving failed")
        }
    }
    
    // remove trip
    func removeTrip(_ trip: Trip) {
        if let index = allTrips.firstIndex(of: trip) {
            allTrips.remove(at: index)
        }
    }
    
    
    // move trip
    func moveTrip(from fromIndex: Int, to toIndex: Int) {
        if (fromIndex == toIndex) {
            return
        }
        
        let movedItem = allTrips[fromIndex]
        allTrips.remove(at: fromIndex)
        allTrips.insert(movedItem, at: toIndex)
    }
    
    // save changes
    func saveChanges() -> Bool {
        var result : Bool = true
        print("Saving trips to \(tripArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allTrips, requiringSecureCoding: true)
            try data.write(to: tripArchiveURL)
            UserDefaults.standard.set(data, forKey: "SavedItems")
        } catch {
            result = false
            print("Write failed")
        }
        return result
    }
    
}
