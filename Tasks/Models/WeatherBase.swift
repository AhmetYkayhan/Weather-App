import Foundation
struct WeatherBase : Codable {
    let temperature: Double?
    let temperature_min: Double?
    let temperature_max: Double?
    
	enum CodingKeys: String, CodingKey {

		case temperature = "temperature"
        case temperature_min = "temperature_min"
        case temperature_max = "temperature_max"
        
    }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        temperature_min = try values.decodeIfPresent(Double.self, forKey: .temperature_min)
        temperature_max = try values.decodeIfPresent(Double.self, forKey: .temperature_max)
		
        /*
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
		message = try values.decodeIfPresent(Int.self, forKey: .message)
		cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
		list = try values.decodeIfPresent([List].self, forKey: .list)
		city = try values.decodeIfPresent(City.self, forKey: .city)
         */
	}

}


/*
import Foundation
struct WeatherBase : Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [List]?
    let city : City?

    enum CodingKeys: String, CodingKey {

        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Int.self, forKey: .message)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([List].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
    }

}
*/
