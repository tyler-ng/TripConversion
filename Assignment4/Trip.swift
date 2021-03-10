//
//  Trip.swift
//  Assignment4
//
//  Created by ThanhTy  on 15/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import Foundation

class Trip: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    var source: String
    var destination: String
    var metric: String
    
    override init() {
        source = ""
        destination = ""
        metric = ""
        
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(source, forKey: "source")
        aCoder.encode(destination, forKey: "destination")
        aCoder.encode(metric, forKey: "metric")
    }
    
    required init(coder aDecoder: NSCoder) {
        source = aDecoder.decodeObject(forKey: "source") as! String
        destination = aDecoder.decodeObject(forKey: "destination") as! String
        metric = aDecoder.decodeObject(forKey: "metric") as! String
        
        super.init()
    }

    
}
