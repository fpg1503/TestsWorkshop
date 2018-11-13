import XCTest
@testable import TestsWorkshop

class TestsWorkshopTests: XCTestCase {
    func testBusinessRuleAddsExclamationPointsToMica() {
        let expectedName = "Mica!!!"
        let mica = Restaurant(id: "1", name: "Mica", visited: false)

        let actualName = BusinessRule().name(of: mica)

        XCTAssertEqual(expectedName, actualName)
    }

    func testBusinessRuleDoesNotAddExclamationPointsToRestaurantsOtherThanMica() {
        let expectedName = "Not Mica"
        let mica = Restaurant(id: "1", name: expectedName, visited: false)

        let actualName = BusinessRule().name(of: mica)

        XCTAssertEqual(expectedName, actualName)
    }
}
