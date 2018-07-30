//
//  ResultCell.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelEstimation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(code: String, data: ResultCost) {
        self.labelCode.text = "\(code) - \(data.service)"
        self.labelPrice.text = "Rp \(data.cost[0].value)"
        self.labelEstimation.text = "\(data.cost[0].etd) days"
    }
    
}
