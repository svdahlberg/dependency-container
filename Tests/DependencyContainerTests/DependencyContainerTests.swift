import XCTest
@testable import DependencyContainer

class DependencyContainerTests: XCTestCase {

    var sut: DependencyContainer!

    override func setUpWithError() throws {
        sut = DependencyContainer()
        super.setUp()
    }

    func testResolve_withRegisteredDependency_shouldInvokeResolver() {
        // Given
        sut.register(MockDependency.self) { MockDependency() }

        // When
        let mockDependency = sut.resolve(MockDependency.self)

        // Then
        XCTAssertEqual(mockDependency?.initInvokeCount, 1)
    }

    func testResolve_withNonRegisteredDependency_shouldReturnNil() {
        // Given

        // When
        let mockDependency = sut.resolve(MockDependency.self)

        // Then
        XCTAssertNil(mockDependency)
    }

}

struct MockDependency {

    var initInvokeCount = 0

    init() {
        initInvokeCount += 1
    }

}
