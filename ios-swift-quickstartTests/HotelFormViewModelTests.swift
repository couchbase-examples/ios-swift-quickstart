import XCTest
@testable import ios_swift_quickstart

class HotelFormViewModelTests: XCTestCase {
    
    var viewModel: HotelFormViewModel!
    var mockHotel: Hotel!
    
    override func setUpWithError() throws {
        mockHotel = Hotel(from: HotelFormModel())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockHotel = nil
    }

    func testGetNewHotelTitle() throws {
        viewModel = HotelFormViewModel(viewMode: .add)
        XCTAssertEqual(viewModel.getTitle(), "New Hotel")
    }
    
    func testGetEditHotelTitle() throws {
        viewModel = HotelFormViewModel(viewMode: .edit(hotel: mockHotel))
        XCTAssertEqual(viewModel.getTitle(), "Edit Hotel")
    }
    
    func testGetDefaultHotel() throws {
        viewModel = HotelFormViewModel(viewMode: .add)
        XCTAssertNotNil(viewModel.hotel)
    }
    
    func testGetEditHotelData() throws {
        var mockHotelFormView =  HotelFormModel()
        mockHotelFormView.title = "Test"
        viewModel = HotelFormViewModel(viewMode: .edit(hotel: Hotel(from: mockHotelFormView)))
        XCTAssertEqual(viewModel.hotel.title, "Test")
        
    }
}
