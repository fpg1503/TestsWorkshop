import SwiftCheck
import XCTest
@testable import TestsWorkshop

extension Restaurant: Arbitrary {
    public static var arbitrary: Gen<Restaurant> = Gen.compose {
        Restaurant(id: $0.generate(), name: $0.generate(), visited: $0.generate())
    }
}

class ArbitraryTest: XCTestCase {

    func testArbitrary() {
        print(String.arbitrary.generate)
        print(Int.arbitrary.generate)
        print(Bool.arbitrary.generate)
        print(Restaurant.arbitrary.generate)
    }

    func testBusinessRuleAddsExclamationPointsToMica() {
        let expectedName = "Mica!!!"
        let mica = Restaurant(id: "1", name: "Mica", visited: false)

        let actualName = BusinessRule().name(of: mica)

        XCTAssertEqual(expectedName, actualName)
    }

    func testBusinessRuleDoesNotAddExclamationPointsToRestaurantsOtherThanMica() {
        let restaurant = Restaurant.arbitrary.suchThat { $0.name != "Mica" }.generate

        let actualName = BusinessRule().name(of: restaurant)

        XCTAssertEqual(restaurant.name, actualName)
    }
}

