//
//  ViewController.swift
//  Tasks
//
//  Created by Ahmet Yasin Kayhan on 15.09.2021.
//

import UIKit
import CoreLocation
  
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //fileprivate let apiKeyWeather = "f2813ff4306cdd4ca305be7032e79095"
    @IBOutlet var table: UITableView!
    
    
    var models = [Weather]()
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register 2 cell
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
       
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    
    // Location
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty,currentLocation == nil {
            currentLocation = locations.first
            locationManager.startUpdatingLocation()
            requestWheatherForLocation()
        }
    }
    func requestWheatherForLocation(){
        guard let  currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let url = "api.openweathermap.org/data/2.5/forecast/daily?lat=\(lat)&lon=\(long)&appid=f2813ff4306cdd4ca305be7032e79095"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
        
        //Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
        //Convert data to Models/some object
        
        
        //Update user İnterface
        
        
        })
    }

    
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
struct Weather: Codable{
    let something: String
}
