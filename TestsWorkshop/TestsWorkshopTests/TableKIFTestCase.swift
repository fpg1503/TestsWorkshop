import XCTest
@testable import TestsWorkshop

class MockedAPIService: APIService {
    var calls = [(Bool, Restaurant)]()
    func get(callback: @escaping (Restaurants) -> Void) {
        let mica = Restaurant(id: "1", name: "Mica", visited: false)
        callback([mica])
    }

    func setVisited(_ visited: Bool, restaurant: Restaurant, callback: @escaping (Restaurant) -> Void) {
        calls.append((visited, restaurant))
        let mica = Restaurant(id: "1", name: "Mica", visited: true)
        callback(mica)
    }


}

class TableKIFTestCase: KIFTestCase {
    let mock = MockedAPIService()

    override func setUp() {
        let viewController = ViewController(apiService: mock)
        UIApplication.shared.keyWindow?.rootViewController = viewController
        viewController.view.backgroundColor = .purple
    }

    func testTest() {
        XCTAssertEqual(mock.calls.count, 0)
        tester().waitForView(withAccessibilityLabel: "Mica", traits: [])
        tester().tapView(withAccessibilityLabel: "Mica")
        tester().waitForView(withAccessibilityLabel: "Mica", traits: .selected)
        XCTAssertEqual(mock.calls.count, 1)
        XCTAssertEqual(mock.calls[0].1.name, "Mica")
        
    }

}
