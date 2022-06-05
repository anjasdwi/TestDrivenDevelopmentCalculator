//
//  ContentViewPage.swift
//  TestDrivenDevelopmentUITests
//
//  Created by Anjas Dwi on 05/06/22.
//

import Foundation
import XCTest

enum ContentViewPageInputCase {
    case valid(Input)
    case invalid(Input)

    var amount: String {
        switch self {
        case .valid(let input), .invalid(let input):
            return input.amount
        }
    }
    
    var result: String {
        switch self {
        case .valid(let input), .invalid(let input):
            return input.result
        }
    }

    typealias Input = (amount: String, result: String)
}

class ContentViewPage {
    var app: XCUIApplication!
    var inputType: ContentViewPageInputCase

    init(app: XCUIApplication, inputType: ContentViewPageInputCase) {
        self.app = app
        self.inputType = inputType
    }

    var amountTextField: XCUIElement {
        app.textFields["amount"]
    }

    var tipPercentageSegmentedController: XCUIElement {
        app.segmentedControls["tipPercentageSegmentedControl"]
    }

    var calculateButton: XCUIElement {
        app.buttons["calculateButton"]
    }

    var resultTip: XCUIElement {
        app.staticTexts["resultTextField"]
    }
}
