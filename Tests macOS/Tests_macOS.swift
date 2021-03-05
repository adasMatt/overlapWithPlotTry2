//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Matthew Adas on 2/26/21.
//

import XCTest

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testPsiFunc() throws {
        
        let overlap = overlapIntegralClass()
        
        var psiValueTest = overlap.psi1sFunc(x: 0.0, y: 0.0, z: 0.0)
        XCTAssertEqual(psiValueTest, 1.4656266867474794, accuracy: 1.0E-10)
        
        psiValueTest = overlap.psi1sFunc(x: 2.0, y: 2.0, z: 2.0)
        XCTAssertEqual(psiValueTest, 0.002103988611387815, accuracy: 1.0E-10)
        
        psiValueTest = overlap.psi1sFunc(x: -1.62, y: -12.5, z: 0.22)
        XCTAssertEqual(psiValueTest, 6.605909806570903e-11, accuracy: 1.0E-15)
        
        
        //XCTAssertEqual(psiValueTest, Double.pi, accuracy: 1.0E-15)
    }
    
    func testPsi2Func() throws {
        
        let overlap = overlapIntegralClass()
        
        var psiValueTest = overlap.psi2pFunc(x: 0.0, y: 0.0, z: 0.0)
        XCTAssertEqual(psiValueTest, 0.0, accuracy: 1.0E-10)
        
        psiValueTest = overlap.psi2pFunc(x: 2.0, y: 2.0, z: 2.0)
        XCTAssertEqual(psiValueTest, 0.03710113946152842, accuracy: 1.0E-10)
        
        psiValueTest = overlap.psi2pFunc(x: -1.62, y: -12.5, z: 0.22)
        XCTAssertEqual(psiValueTest, 7.231436229094605e-7, accuracy: 1.0E-10)

        
    }
    
    func testOverlap() throws {
        
        let overlap = overlapIntegralClass()
        
        var overlapTest = overlap.overlapMeanFunc(howManyTimes: 5000000, howFarAreTheProtons: 0)
        XCTAssertEqual(overlapTest, 1.0, accuracy: 5.0E-2)

        overlapTest = overlap.overlapMeanFunc(howManyTimes: 5000000, howFarAreTheProtons: overlap.a)
        // assert 0.8583853627333655
        XCTAssertEqual(overlapTest, 0.8583853627333655, accuracy: 5.0E-2)
    }
    /*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
 */
}
