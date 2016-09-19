//
//  snapcodeTests.swift
//  snapcodeTests
//
//  Created by Marek Hrusovsky on 9/17/16.
//  Copyright © 2016 Marek Hrusovsky. All rights reserved.
//

import XCTest

@testable import snapcode

class snapcodeTests: XCTestCase {
   
    var parser : SVGParser?
    
    
    override func setUp() {
        super.setUp()
        let svg : String = try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("snapcode2", ofType: "svg")!, encoding: NSUTF8StringEncoding) as String
        parser = SVGParser(svg: svg)
        parser!.fillColor = "FFDDFF"
        parser!.parse()
        
        
        let svg2 : String = try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("snapcode", ofType: "svg")!, encoding: NSUTF8StringEncoding) as String
        let parser2 = SVGParser(svg: svg2)
        parser2.parse()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParser() {
        //XCTAssertEqual(SVGParser().parse(),[])
    
        
    }
    
    func testFindPathContainingFillColor() {
    
        let expected = ["M0,0,326.74,45.66M485.53,45.66A16.43,16.43,0,0,0,485.53,78.52A16.43,16.43,0,0,0,485.53,45.66M591.4,45.66A16.43,16.43,0,0,0,591.4,78.52A16.43,16.43,0,0,0,591.4,45.66M644.33,45.66A16.43,16.43,0,0,0,644.33,78.52A16.43,16.43,0,0,0,644.33,45.66M697.26,45.66A16.43,16.43,0,0,0,697.26,78.52A16.43,16"]
        XCTAssertEqual(parser!.pointLines,expected)
    }
    
    
    func testLookForPoints() {
        
        let expected : [String] = ["485.53,45.66", "591.4,45.66", "644.33,45.66", "697.26,45.66"]

        XCTAssertEqual(parser!.pointsAsString,expected)
    }
    
    func testPathCoordinates() {
//        let expected : [PointCoordinate] = [
//            PointCoordinate(x: 8, y: 1),
//            PointCoordinate(x: 10, y: 1),
//            PointCoordinate(x: 11, y: 1),
//            PointCoordinate(x: 12, y: 1)]
//        
//        XCTAssertTrue(parser!.pointCoordinates == expected)
//        
        //29.23 ,45.66-32.86/2
//        let a = [182.64, 394.36, 606.08, 817.8, 1029.52, 1241.24, 1452.96, 1664.68, 1876.4, 2088.16, 2299.88, 2511.6, 2723.32, 2935.04, 3146.76, 3358.48, 3570.2, 3781.92]
//        let b = [45.66, 98.59, 151.52, 204.45, 257.38, 310.31, 363.24, 416.17, 469.10, 522.04, 574.97, 627.9, 680.83, 733.76, 786.69, 839.62, 892.55, 945.48]
//        
//        let c = ["62.09", "115.02", "167.95", "220.88", "273.81", "326.74", "379.67", "432.6", "485.53", "538.47", "591.4", "644.33", "697.26", "750.19", "803.12", "856.05", "908.98", "961.91"]
//        
//        let d = ["45.66", "98.59", "151.52", "204.45", "257.38", "310.31", "363.24", "416.17", "469.10", "522.04", "574.97", "627.9", "680.83", "733.76", "786.69", "839.62", "892.55", "945.48"]
//        
//        
//
//        
        //print(linetoPointy.map{Float($0)! / 4 + 0.001})
        //print(movelinPointx.map{Float($0)! / 4 + 0.001})
        //print("", b)
    }
 
    
}
