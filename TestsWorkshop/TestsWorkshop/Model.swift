import Foundation

struct Restaurant: Codable {
    let id: String
    let name: String
    var visited: Bool
}

typealias Restaurants = [Restaurant]

class BusinessRule {

    /// Iff restaurant is Mica add exclamation points
    /// because Mica is nice!
    func name(of restaurant: Restaurant) -> String {
        if restaurant.name == "Mica" {
            return restaurant.name + "!!!"
        }
        return restaurant.name
    }
}
