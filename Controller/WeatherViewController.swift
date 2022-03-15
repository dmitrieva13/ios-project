//
//  ViewController.swift
//  Weather
//
//  Created by Varvara on 02.03.2022.
//

import UIKit

import UIKit
import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    let rightNowView = RightNowView(frame: CGRect(x: 0, y: 25, width: 310, height: 600))
    let weatherDetailView = WeatherDetailView(frame: CGRect(x: 20, y: 230, width: 280, height: 100))
    
    var city = ""
    var weatherResult: Result?
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        clearAll()
        view.addSubview(rightNowView)
        
        getLocation()
    }
    
    func clearAll() {
        rightNowView.clear()
    }
    
    func getWeather() {
        NetworkService.shared.getWeather(onSuccess: { (result) in
            self.weatherResult = result
            
            self.updateViews()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateViews() {
        updateTopView()
    }
    
    func updateTopView() {
        guard let weatherResult = weatherResult else {return}
        rightNowView.updateView(currentWeather: weatherResult.current, city: city)
    }
    
    func getLocation() {
       
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.startUpdatingLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            
            NetworkService.shared.setLatitude(latitude)
            NetworkService.shared.setLongitude(longitude)
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            self.city = city
                        }
                    }
                }
            }
            getWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
}


