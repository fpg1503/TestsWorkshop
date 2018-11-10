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

    }
}

