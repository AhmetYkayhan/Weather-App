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
    
    
    var models = [WeatherBase]()
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var current : WeatherBase? //struct'ın içinde bulunması gerekiyor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register 2 cell
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
       
       
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
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        // this api calls five days and three hours
        //let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=f2813ff4306cdd4ca305be7032e79095"
        let url = "https://www.mockachino.com/46baac8b-4d59-46/weatherforecast"
        let request = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
        //let url = "https://www.mockachino.com/f1039952-0f66-4e/weather"
        //Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
        //Convert data to Models/some objectm
            var json: WeatherBase?
            do {
                json = try JSONDecoder().decode(WeatherBase.self, from: data)
            }
            catch{
                print ("error = \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            
            //test api logs
            print("temperature: ",  result.temperature)
            print("temperature_min: ", result.temperature_min)
            print("temperature_max: ", result.temperature_max)
            
            //self.models.append(result)
            //append(contenetsOf:[sequance] )
            self.models.append(contentsOf: [result,result,result,result,result])
            // test apidedki veriyi çokluyoruz görüntü olarak  büyük gözüksün
            
            let current = result.temperature
            // struct ın içinde bulunacak alanın ataması
            
            
        //Update user İnterface
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
            }
        })
        request.resume()
        
    }
    
    func createTableHeader() -> UIView{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let temparatureLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20,
                                                    height: headerView.frame.size.height/2))
        headerView.addSubview(locationLabel)
        headerView.addSubview(summaryLabel)
        headerView.addSubview(temparatureLabel)
        
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        temparatureLabel.textAlignment = .center
        
        
        locationLabel.text = "Current Location"
        summaryLabel.text = "clear"
        temparatureLabel.text = " 17,3°"            //\(self.current?.temperature)
        temparatureLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
  
        return headerView
    }

    
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,for: indexPath) as! WeatherTableViewCell
        cell.configure(with: models [indexPath.row])
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

