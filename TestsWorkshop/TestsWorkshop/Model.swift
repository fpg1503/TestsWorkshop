import Foundation

struct Restaurant: Codable {
    let id: String
    let name: String
    var visited: Bool
}

typealias Restaurants = [Restaurant]
