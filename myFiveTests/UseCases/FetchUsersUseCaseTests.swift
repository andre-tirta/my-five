import XCTest
import Combine
@testable import myFive

class FetchUsersUseCaseTests: XCTestCase {
    private var mockAPIClient: MockAPIClient?
    private var fetchUsersUseCase: FetchUsersUseCase?
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        if let mockAPIClient = mockAPIClient {
            fetchUsersUseCase = FetchUsersUseCase(apiClient: mockAPIClient)
        }
    }

    override func tearDown() {
        mockAPIClient = nil
        fetchUsersUseCase = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testExecuteSuccess() {
        guard let fetchUsersUseCase = fetchUsersUseCase, let mockAPIClient = mockAPIClient else {
            XCTFail("Test setup failed")
            return
        }

        // Arrange
        let geo = Geo(lat: "-37.3159", lng: "81.1496")

        let address = Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: geo
        )

        let company = Company(
            name: "Romaguera-Crona",
            catchPhrase: "Multi-layered client-server neural-net",
            bs: "harness real-time e-markets"
        )

        let user = User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            address: address,
            company: company
        )

        let user2 = User(
            id: 2,
            name: "Ervin Howell",
            username: "Antonette",
            email: "Shanna@melissa.tv",
            phone: "010-692-6593 x09125",
            website: "anastasia.net",
            address: address,
            company: company
        )

        let expectedUsers = [
            user,
            user2
        ]

        mockAPIClient.mockResult = Just(expectedUsers)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Fetch users successfully")

        // Act
        fetchUsersUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { users in
                // Assert
                XCTAssertEqual(users, expectedUsers, "Fetched users should match expected users.")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testExecuteFailure() {
        guard let fetchUsersUseCase = fetchUsersUseCase, let mockAPIClient = mockAPIClient else {
            XCTFail("Test setup failed")
            return
        }

        // Arrange
        let expectedError = NSError(domain: "TestError", code: 123, userInfo: nil)
        mockAPIClient.mockResult = Fail<[User], Error>(error: expectedError)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Fetch users failed")

        // Act
        fetchUsersUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    // Assert
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription, "Error should match expected error.")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no users but got some.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
