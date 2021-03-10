//
//  MyNavigationController.swift
//  Assignment4
//
//  Created by ThanhTy  on 16/11/20.
//  Copyright © 2020 ThanhTy . All rights reserved.
//

import UIKit

public class MyNavigationController: UINavigationController, UINavigationBarDelegate {

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        var result : Bool = true
        
        if let theController = self.topViewController as? NewTripViewController {
            result = theController.validateData()
        }
        
        return result
    }


}
