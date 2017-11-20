//
//  ViewController.swift
//  WeatherApp
//
//  Created by Konstantin Konstantinov on 11/18/17.
//  Copyright © 2017 Konstantin Konstantinov. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    
    
    let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func fetchWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            [weak self] response in
            if response.result.isSuccess {
                print("Success! Weather data has been fetched")
                
                let weatherJSON = JSON(response.result.value!)
                self?.updateWeatherData(json: weatherJSON)
            } else {
                let errorText = String(describing: response.result.error)
                print("Error: \(errorText)")
                self?.cityLabel.text = "Connection Issue"
            }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateWeatherData(json: JSON) {
        //let weatherJSON = json["main"]
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            print("latitude: \(latitude), longitude: \(longitude)")
            
            let params = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            fetchWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


