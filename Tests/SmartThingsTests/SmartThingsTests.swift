import XCTest
@testable import SmartThings

final class SmartThingsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SmartThings().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
