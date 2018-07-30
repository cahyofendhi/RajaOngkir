//
//  CityVC.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

protocol CityDelegate {
    func citySelected(pageType: PlaceType, city: CityResult)
}

class CityVC: BaseVC {
    
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var delegate: CityDelegate?
    
    var data = [CityResult]()
    var dataOrigi = [CityResult]()
    
    var provId: String = ""
    var page = PlaceType.origin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetailNavBar(title: Constan.TITLE_CITY)
        self.initTableView()
        self.textSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func initTableView() {
        self.tableView.registerNib(xibName: Constan.PLACECELL, identifier: Constan.PLACECELL)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        
        self.loading.alpha  = 1.0
        ProvCityViewModel.instance.getCityData(provId: self.provId) { dataCity in
            self.loading.alpha  = 0
            self.data.append(contentsOf: dataCity)
            self.dataOrigi.append(contentsOf: self.data)
            self.tableView.reloadData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let s = textField.text
        if (s?.count)! > 0 {
            var search = [CityResult]()
            for item in self.dataOrigi {
                if item.cityName.lowercased().range(of: s!) != nil {
                    search.append(item)
                }
            }
            self.data.removeAll()
            self.data.append(contentsOf: search)
        } else {
            self.data.append(contentsOf: self.dataOrigi)
        }
        self.tableView.reloadData()
    }
    
}

extension CityVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: Constan.PLACECELL) as! PlaceCell
        cell.setCityData(self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.citySelected(pageType: self.page, city: self.data[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

