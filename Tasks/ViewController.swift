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
        //self.parseByCodableProtocol
        
       
       
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
        print("4.0")
        if !locations.isEmpty,currentLocation == nil {
            currentLocation = locations.first
            locationManager.startUpdatingLocation()
            print("4")
            requestWheatherForLocation()
        }
        print("4.2")
    }
    func requestWheatherForLocation(){
        guard let  currentLocation = currentLocation else {
            print("5.0.1")
            return
        }
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=f2813ff4306cdd4ca305be7032e79095"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
        
        //Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                print("6")
                return
            }
            
        //Convert data to Models/some objectm
            var json: WeatherBase?
            do {
                json = try JSONDecoder().decode(WeatherBase.self, from: data)
                print("7")
            }
            catch{
                print ("error = \(error)")
            }
            
            guard let result = json else {
                print("8")
                return
            }
           // print(result.list)
            
            //let entries = result
            //self.models.append(contentsOf: entries)
        
        //Update user İnterface
            DispatchQueue.main.async {
                self.table.reloadData()
                print("9")
            }
        
        }).resume()
    }

    
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,for: indexPath) as! WeatherTableViewCell
        //cell.configure(with: models [indexPath.row])
        
        return cell
    }
    
}

