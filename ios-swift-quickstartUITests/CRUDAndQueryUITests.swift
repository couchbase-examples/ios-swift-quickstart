
import Foundation
import XCTest

final class CRUDAndQueryUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {

        app = nil
    }
    
    func testCRUDandQuery() throws {
        app.buttons["addHotelButton"].tap()
        try hotelFormViewTests()
        app.buttons["HotelFormViewAcceptButton"].tap()
        try searchQueryTests()
        try detailsViewTests()
        app.buttons["EditHotelButton"].tap()
        try editHotelViewTests()
        app.buttons["HotelFormViewAcceptButton"].tap()
        try searchQueryTestsAfterEdit()
        try swipeToDeleteTest()
    }
    
    func hotelFormViewTests() throws {
        let nameFormTextField = app.textFields["NameFormTextField"]
        XCTAssertTrue(nameFormTextField.exists, "The text field for name inside HotelFormView couldn't be found. Check if accessibilityIdentifiers are the same")
        nameFormTextField.tap()
        nameFormTextField.typeText("Testing hotel create functionality")
        
    }
    
    func searchQueryTests() throws {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Couldn't find any searchFields")
        searchField.tap()
        searchField.typeText("Testing")
        sleep(1)
        let nameLabel = app.staticTexts["Testing hotel create functionality"]
        XCTAssertTrue(nameLabel.exists, "Hotel should be inside the list")
        nameLabel.tap()
    }
    
    func detailsViewTests() throws {
        let nameLabel = app.staticTexts["Testing hotel create functionality"]
        XCTAssertTrue(nameLabel.exists, "Hotel Name should be displayed properly")
    }
    
    func editHotelViewTests() throws {
        let addressFormTextField = app.textFields["AddressFormTextField"]
        XCTAssertTrue(addressFormTextField.exists, "The text field for title inside HotelFormView couldn't be found. Check if accessibilityIdentifiers are the same")
        addressFormTextField.tap()
        addressFormTextField.typeText("Testing hotel editing functionality")
    }
    
    func searchQueryTestsAfterEdit() throws {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Couldn't find any searchFields")
        sleep(1)
        let addressLabel = app.staticTexts["Testing hotel editing functionality  "]
        XCTAssertTrue(addressLabel.exists, "Couldn't find specified item")
    }
    
    func swipeToDeleteTest() throws {
        let addressLabel = app.staticTexts["Testing hotel editing functionality  "]
        addressLabel.swipeLeft()
        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists, "Delete button should appear after swiping")
        deleteButton.tap()
        
        let alert = app.alerts["Are you sure you want to delete this item?"]
        XCTAssertTrue(alert.exists, "Alert should appear")

        let confirmDeleteButton = alert.buttons["Delete"]
        XCTAssertTrue(confirmDeleteButton.exists, "Delete confirmation button should appear")
        confirmDeleteButton.tap()

        XCTAssertFalse(addressLabel.exists, "Item should be deleted from the list")
    }
}
