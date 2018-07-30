//
//  CostVC.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class CostVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var data: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetailNavBar(title: Constan.TITLE_RESULT)
        self.initTableView()
    }

    func initTableView() {
        self.tableView.registerNib(xibName: Constan.RESULTCELL, identifier: Constan.RESULTCELL)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        
    }
    
}

extension CostVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data!.costs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: Constan.RESULTCELL) as! ResultCell
        cell.selectionStyle = .none
        cell.setData(code: self.data!.name, data: self.data!.costs[indexPath.row])
        return cell
    }
    
}
