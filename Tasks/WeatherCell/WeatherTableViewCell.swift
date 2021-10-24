//
//  WeatherTableViewCell.swift
//  Tasks
//
//  Created by Ahmet Yasin Kayhan on 15.09.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var maxTempatureLabel: UILabel!
    @IBOutlet var minTempatureLabel:UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "WeatherTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: WeatherBase){
        self.minTempatureLabel.textAlignment = .center
        self.maxTempatureLabel.textAlignment = .center
        
        self.minTempatureLabel.text = "\(Double(model.temperature_min!))°"
        self.maxTempatureLabel.text = "\(Double(model.temperature_max!))°"
        //self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.time)))
        self.iconImageView.contentMode = .scaleAspectFit
        // ## api içerisindeki icon modeline erişilen alan
        /*
        let icon = model.icon?.lowercased()
        if icon.contains("sun"){
            self.iconImageView.image = UIImage(named: "sun")
        }
        else if icon.contains("rain") {
            self.iconImageView.image = UIImage(named: "rain")
        }
        else {
            self.iconImageView.image = UIImage(named: "cloud")
        }*/ 
    }
    func getDayForDate(_ date: Date?) -> String{
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
    
}
