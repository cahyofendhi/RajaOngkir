//
//  PlaceCell.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ provData: ProvData) {
        self.labelName.text = provData.province
    }
    
    func setCityData(_ cityData: CityResult) {
        self.labelName.text = cityData.cityName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
