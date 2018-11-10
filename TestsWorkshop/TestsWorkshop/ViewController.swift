import UIKit

class ViewController: UITableViewController {
    let apiService = APIService()
    var restaurants: Restaurants = []

    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        apiService.get { [weak self] restaurants in
            self?.restaurants = restaurants
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let restaurant = restaurants[indexPath.row]

        cell.textLabel?.text = restaurant.name
        cell.accessoryType = restaurant.visited ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let restaurant = restaurants[index]
        apiService.setVisited(true, restaurant: restaurant) { [tableView, weak self] (newRestaurant) in
            self?.restaurants[index] = newRestaurant
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}
