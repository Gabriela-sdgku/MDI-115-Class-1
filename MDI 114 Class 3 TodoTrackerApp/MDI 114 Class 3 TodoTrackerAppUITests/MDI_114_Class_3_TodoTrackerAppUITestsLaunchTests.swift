//
//  MDI_114_Class_3_TodoTrackerAppUITestsLaunchTests.swift
//  MDI 114 Class 3 TodoTrackerAppUITests
//
//  Created by Gabriela Sanchez on 04/11/25.
//

import XCTest

final class MDI_114_Class_3_TodoTrackerAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
