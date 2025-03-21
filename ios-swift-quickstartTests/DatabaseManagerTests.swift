import Combine
import XCTest
@testable import ios_swift_quickstart

class DatabaseManagerTests: XCTestCase {
    
    var databaseManager: DatabaseManager!
    var mockHotel: Hotel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        databaseManager = DatabaseManager()
        mockHotel = Hotel(from: HotelFormModel())
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        databaseManager.deleteElementWithName("Testing hotel create functionality")
        databaseManager.deleteElementWithName("Testing hotel update functionality 2")
        databaseManager = nil
        mockHotel = nil
        cancellables = nil
    }
    
    func testAddHotelandQuery() {
        var mockHotelForm =  HotelFormModel()
        mockHotelForm.name = "Testing hotel create functionality"
        let expectation = XCTestExpectation(description: "Hotel Should be added to database")
        databaseManager.queryUpdates
            .dropFirst()
            .sink(receiveValue: {  hotels in
                let testHotel = hotels.first
                XCTAssertEqual(testHotel?.name, "Testing hotel create functionality", "Didn't receive hotel with created name")
                expectation.fulfill()
            })
            .store(in: &cancellables)
                
        databaseManager.addNewElement(Hotel(from: mockHotelForm))
        sleep(1)
        databaseManager.queryElements(descending: true, textSearch: "Testing hotel create functionality")
        wait(for: [expectation], timeout: 2)
    }
    
    func testEditHotelandQuery() {
        var mockHotelForm =  HotelFormModel()
        mockHotelForm.name = "Testing hotel update functionality"
        let expectation = XCTestExpectation(description: "Hotel Should be updated in database")
        databaseManager.queryUpdates
            .dropFirst()
            .sink(receiveValue: {  hotels in
                let testHotel = hotels.first
                XCTAssertEqual(testHotel?.name, "Testing hotel update functionality 2", "Didn't receive hotel with updated name")
                expectation.fulfill()
            })
            .store(in: &cancellables)
                
        databaseManager.addNewElement(Hotel(from: mockHotelForm))
        sleep(1)
        mockHotelForm.name = "Testing hotel update functionality 2"
        databaseManager.updateExistingElement(Hotel(from: mockHotelForm))
        sleep(1)
        databaseManager.queryElements(descending: true, textSearch: "Testing")
        wait(for: [expectation], timeout: 2)
    }
    
    func testDeleteHotelandQuery() {
        var mockHotelForm =  HotelFormModel()
        mockHotelForm.name = "Testing hotel delete functionality"
        let expectation = XCTestExpectation(description: "Hotel Should be removed from database")
        databaseManager.queryUpdates
            .dropFirst()
            .sink(receiveValue: {  hotels in
                XCTAssertEqual(hotels.count , 0, "Hotel wasn't removed from the database")
                expectation.fulfill()
            })
            .store(in: &cancellables)
                
        databaseManager.addNewElement(Hotel(from: mockHotelForm))
        sleep(1)
        databaseManager.deleteElement(Hotel(from: mockHotelForm))
        sleep(1)
        databaseManager.queryElements(descending: true, textSearch: "Testing hotel delete functionality")
        wait(for: [expectation], timeout: 2)
    }
}
