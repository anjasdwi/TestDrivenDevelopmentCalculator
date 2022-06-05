//
//  TestDrivenDevelopmentUITests.swift
//  TestDrivenDevelopmentUITests
//
//  Created by Anjas Dwi on 05/06/22.
//

import XCTest

class when_content_view_is_shown: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        let input = ContentViewPageInputCase.Input(amount: "", result: "")
        contentViewPage = ContentViewPage(app: app, inputType: .valid(input))
        continueAfterFailure = false
        app.launch()
    }

    func test_should_make_sure_that_the_total_text_field_contains_default_value() {
        XCTAssertEqual(contentViewPage.amountTextField.value as! String, "Enter amount")
    }
    
    func test_should_make_sure_20_percent_default_tip_option_is_selected() {
        let segmentedControllerButton = contentViewPage.tipPercentageSegmentedController.buttons.element(boundBy: 0)
        
        XCTAssertEqual(segmentedControllerButton.label, "10%")
        XCTAssertTrue(segmentedControllerButton.isSelected)
    }

    override func tearDown() {
        // clean up
    }
}

class when_calculate_tip_button_is_pressed_for_valid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        let input = ContentViewPageInputCase.Input(amount: "100", result: "$10.00")
        contentViewPage = ContentViewPage(app: app, inputType: .valid(input))
        continueAfterFailure = false
        app.launch()
        
        contentViewPage.amountTextField.tap()
        contentViewPage.amountTextField.typeText(contentViewPage.inputType.amount)
        contentViewPage.calculateButton.tap()
    }

    func test_should_make_that_tip_is_displayed_on_the_screen() {
        let _ = contentViewPage.resultTip.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.resultTip.label, contentViewPage.inputType.result)
    }

    override func tearDown() {
        // clean up
    }
}

class when_calculate_tip_button_is_pressed_for_invalid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        let input = ContentViewPageInputCase.Input(amount: "-100", result: "Invalid Input")
        contentViewPage = ContentViewPage(app: app, inputType: .valid(input))
        continueAfterFailure = false
        app.launch()
        
        contentViewPage.amountTextField.tap()
        contentViewPage.amountTextField.typeText(contentViewPage.inputType.amount)
        contentViewPage.calculateButton.tap()
    }

    func test_should_clear_amount_for_invalid_input() {
        XCTAssertEqual(contentViewPage.amountTextField.value as! String, "Enter amount")
    }

    func test_should_display_error_message_for_invalid_input() {
        let _ = contentViewPage.resultTip.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.resultTip.label, contentViewPage.inputType.result)
    }

    override func tearDown() {
        // clean up
    }
}
