import Foundation
struct Rain : Codable {
	let threeHour : Double?

	enum CodingKeys: String, CodingKey {

		case threeHour = "3h"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		threeHour = try values.decodeIfPresent(Double.self, forKey: .threeHour)
	}

}
