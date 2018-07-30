//
//  ViewController.swift
//  RajaOngkir
//
//  Created by Rumah Ulya on 29/07/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

enum PlaceType {
    case origin
    case destination
}

class MainVC: BaseVC, CityDelegate, SSRadioButtonControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var buttonOrigin: RoundUIButton!
    @IBOutlet weak var buttonDestination: RoundUIButton!
    
    @IBOutlet weak var buttonSubmit: RoundUIButton!
    @IBOutlet weak var textWeight: AppTextField! {
        didSet{
            textWeight.keyboardType = UIKeyboardType.numberPad
        }
    }
    @IBOutlet weak var buttonJNE: SSRadioButton!
    @IBOutlet weak var buttonPOS: SSRadioButton!
    @IBOutlet weak var buttonTIKI: SSRadioButton!
    var radioButtonController: SSRadioButtonsController?
    
    var page = PlaceType.origin
    var addressOrigin: CityResult?
    var addressDestination: CityResult?
    
    var courier: String = "jne"
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    func initView() {
        self.title  = Constan.TITLE_APP
        
        self.buttonOrigin.addTarget(self, action: #selector(self.actionOrigin(sender:)), for: .touchUpInside)
        self.buttonDestination.addTarget(self, action: #selector(self.actionDestination(sender:)), for: .touchUpInside)
        self.buttonSubmit.addTarget(self, action: #selector(self.actionCost(sender:)), for: .touchUpInside)

        radioButtonController = SSRadioButtonsController(buttons: self.buttonJNE, self.buttonPOS, self.buttonTIKI)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        textWeight.delegate = self
        buttonJNE.isSelected = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func actionOrigin(sender: UIButton) {
        self.page   = PlaceType.origin
        self.performSegue(withIdentifier: Constan.SEGUE_PROVINCE, sender: self)
    }
    
    @objc func actionDestination(sender: UIButton) {
        self.page   = PlaceType.destination
        self.performSegue(withIdentifier: Constan.SEGUE_PROVINCE, sender: self)
    }
    
    @objc func actionCost(sender: UIButton) {
        if self.addressOrigin == nil{
            self.view.makeToast(message: "Please select your origin")
        } else if self.addressDestination == nil {
            self.view.makeToast(message: "Please select your destination")
        } else if self.textWeight.text?.count == 0 {
            self.view.makeToast(message: "Please set your weight")
        } else {
            let sv  = displaySpinner(onView: self.view)
            ApiRepository.instance.postCost(originId: (self.addressOrigin?.cityID)!,
                                            destinationId: (self.addressDestination?.cityID)!,
                                            weight: self.textWeight.text!,
                                            courier: self.courier,
                                            result: { (data) in
                                              
                                                self.removeSpinner(spinner: sv)
                                                self.result = data.rajaongkir.results[0]
                                                self.performSegue(withIdentifier: Constan.SEGUE_COST, sender: self)
                                                
            }) { (error) in
                self.removeSpinner(spinner: sv)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constan.SEGUE_PROVINCE {
            if let vc   = segue.destination as? ProvinceVC {
                vc.page = self.page
                vc.mainVC = self
            }
        } else if (segue.identifier == Constan.SEGUE_COST) {
            if let vc   = segue.destination as? CostVC {
                vc.data = self.result
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberOnly = NSCharacterSet.init(charactersIn: "0123456789")
        let stringFromTextField = NSCharacterSet.init(charactersIn: string)
        let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
        
        return strValid
    }
    
    func citySelected(pageType: PlaceType, city: CityResult) {
        print("Result \(city.cityName)")
        let address = "\(city.cityName), \(city.province)"
        if pageType == PlaceType.origin {
            self.addressOrigin  = city
            self.buttonOrigin.setTitle(address, for: .normal)
        } else {
            self.addressDestination = city
            self.buttonDestination.setTitle(address, for: .normal)
        }
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        if let type = selectedButton?.currentTitle {
            print(type)
            self.courier = type.lowercased()
        }
        
    }
    
}

