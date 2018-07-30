//
//  TableExtention.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerNib(xibName: String, identifier: String) {
        let nib = UINib(nibName: xibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

