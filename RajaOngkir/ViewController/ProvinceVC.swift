//
//  ProvinceVC.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

class ProvinceVC: BaseVC {
    
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var data = [ProvData]()
    var dataOrigi = [ProvData]()
    var provId: String = ""
    var page = PlaceType.origin
    var mainVC: MainVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    func initView() {
        initDetailNavBar(title: Constan.TITLE_PROVINCE)
        self.initTableView()
        self.textSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func initTableView() {
        self.tableView.registerNib(xibName: Constan.PLACECELL, identifier: Constan.PLACECELL)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        
        self.loading.alpha  = 1.0
        ProvCityViewModel.instance.getProvData { dataProv in
            self.loading.alpha  = 0
            self.data.append(contentsOf: dataProv)
            self.dataOrigi.append(contentsOf: self.data)
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constan.SEGUE_CITY {
            if let vc   = segue.destination as? CityVC {
                vc.provId = self.provId
                vc.page = self.page
                vc.delegate = self.mainVC
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let s = textField.text
        if (s?.count)! > 0 {
            var search = [ProvData]()
            for item in self.dataOrigi {
                if item.province!.lowercased().range(of: s!) != nil {
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

extension ProvinceVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: Constan.PLACECELL) as! PlaceCell
        cell.setData(self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.provId = self.data[indexPath.row].provinceID!
        self.performSegue(withIdentifier: Constan.SEGUE_CITY, sender: self)
    }
}

