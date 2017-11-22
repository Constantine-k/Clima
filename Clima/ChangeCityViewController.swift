//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Konstantin Konstantinov on 11/18/17.
//  Copyright © 2017 Konstantin Konstantinov. All rights reserved.
//

import UIKit


protocol ChangingCityDelegate {
    func userEnteredANewCity(name: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangingCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!

    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        if let cityName = changeCityTextField.text {
            delegate?.userEnteredANewCity(name: cityName)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
