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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangingCityDelegate {

    //Constants
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let appID = "e72ca729af228beabd5d20e3b7749713"
    
    let locationManager = CLLocationManager()
    var weatherModel: WeatherDataModel?

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
        if let temperature = json["main"]["temp"].double {
            let temperatureCelsius = Int(temperature - 273.15)
            let condition = json["weather"][0]["id"].intValue
            let city = json["name"].stringValue
            
            weatherModel = WeatherDataModel(temperature: temperatureCelsius, condition: condition, city: city)
        } else {
            cityLabel.text = "Weather Unavailable"
        }
        
        updateUIWithWeatherData()
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData() {
        if let weatherModel = weatherModel {
            cityLabel.text = weatherModel.city
            temperatureLabel.text = String(weatherModel.temperature) + "°"
            weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
        }
    }
    
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
            
            let params = ["lat": latitude, "lon": longitude, "appid": appID]
            
            fetchWeatherData(url: weatherURL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCity(name: String) {
        let parameters = ["q": name, "appid": appID]
        fetchWeatherData(url: weatherURL, parameters: parameters)
    }
    
    // Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as? ChangeCityViewController
            destinationVC?.delegate = self
        }
    }
    
}
