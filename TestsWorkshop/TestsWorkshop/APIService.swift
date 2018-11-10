import Foundation

class APIService {
    enum Endpoints {
        var baseURL: URL { return URL(string: "http://localhost:4567")! }

        case getRestaurants
        case putRestaurant(id: String)

        var url: URL {
            switch self {
            case .getRestaurants:
                return baseURL.appendingPathComponent("restaurants")
            case let .putRestaurant(id):
                return baseURL.appendingPathComponent("restaurant").appendingPathComponent(id)
            }
        }
    }

    let session = URLSession.shared

    func get(callback: @escaping (Restaurants) -> Void) {
        let request = URLRequest(url: Endpoints.getRestaurants.url)
        session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data else { return }
            let restaurants = try! JSONDecoder().decode(Restaurants.self, from: data)
            callback(restaurants)
        }).resume()
    }

    func setVisited(_ visited: Bool,
                    restaurant: Restaurant,
                    callback: @escaping (Restaurant) -> Void) {
        var myRestaurant = restaurant
        myRestaurant.visited.toggle()

        var request = URLRequest(url: Endpoints.putRestaurant(id: myRestaurant.id).url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(myRestaurant)

        session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data else { return }
            let restaurant = try! JSONDecoder().decode(Restaurant.self, from: data)
            callback(restaurant)
        }).resume()
    }
}
