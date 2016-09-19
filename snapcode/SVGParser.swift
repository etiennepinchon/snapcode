import Foundation

struct PointCoordinate {
    let x : Int
    let y : Int

}

func ==(lhs: PointCoordinate, rhs: PointCoordinate) -> Bool {
    if (lhs.x == rhs.x &&
        lhs.y == rhs.y) {
        return true
    }
    return false
}

class SVGParser : NSObject {
    
    var svg : String
    var pointLines : [String] = [String]()
    var pointsAsString : [String] = [String]()
    var fillColor : String = "AFFC00"
    var pointCoordinates : [PointCoordinate] = [PointCoordinate]()
    
    init(svg: String) {
        
        self.svg = svg
        super.init()
    }
    
    func parse() {
        
        findPathContainingFillColor(fillColor)
        lookForPoints()
        removeFirstPoint()
        translateStringPoints()
    }
    
    func translateStringPoints() {
        
        let x = ["62.09", "115.02", "167.95", "220.88", "273.81", "326.74", "379.67", "432.6", "485.53", "538.47", "591.4", "644.33", "697.26", "750.19", "803.12", "856.05", "908.98", "961.91"]
        
        let y = ["45.66", "98.59", "151.52", "204.45", "257.38", "310.31", "363.24", "416.17", "469.10", "522.04", "574.97", "627.9", "680.83", "733.76", "786.69", "839.62", "892.55", "945.48"]
        
        
        pointCoordinates.removeAll()
        for point in pointsAsString {
            let newPoint = point.stringByReplacingOccurrencesOfString("\"", withString: "")
            let pole = newPoint.componentsSeparatedByString(",")
            if pole.count == 2 {
                var coordinateX : Int?
                var coordinateY : Int?
                if x.contains(pole[0]) {
                   coordinateX = x.indexOf(pole[0])!
                } else if y.contains(pole[0]) {
                   coordinateX = y.indexOf(pole[0])!
                }
                if x.contains(pole[1]) {
                    coordinateY = x.count - 1 - x.indexOf(pole[1])!
                } else if y.contains(pole[1]) {
                    coordinateY = y.count - 1 - y.indexOf(pole[1])!
                }
                
                if coordinateX != nil && coordinateY != nil {
                    pointCoordinates.append(PointCoordinate(x: coordinateX!, y: coordinateY!))
                }
            }
        }
        
        
        
    }
    
    
    func removeFirstPoint() {
        pointsAsString.removeAtIndex(0)
    }
    
    func lookForPoints() {
        
        pointsAsString.removeAll()
        if let line = pointLines.first {
            if let range = line.rangeOfString("M") {
                let substring = line.substringFromIndex(range.startIndex)
                let lines = substring.componentsSeparatedByString("M")
                
                for giberishLine in lines {
                    if let point = giberishLine.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet()).first {
                        if point != "" {
                            pointsAsString.append(point)
                        }
                    }
                }
            }
        }
    }
    
    func findPathContainingFillColor(text: String) {
        
        var lines = svg.componentsSeparatedByString("<path ")
        var tagFilteredLines = [String]()
        for line in lines {
            if let range = line.rangeOfString("/>") {
                let substring = line.substringToIndex(range.endIndex.advancedBy(-2))
                tagFilteredLines.append(substring)
            }
        }
        
        var pathLines = [String]()
        for line in tagFilteredLines {
            if line.lowercaseString.rangeOfString(text.lowercaseString) != nil {
                pathLines.append(line)
            }
        }
        
        pointLines.removeAll()
        
        if let pathLine = pathLines.first {
            lines =  pathLine.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            for line in lines {
                let dLines = line.componentsSeparatedByString("=")
                if dLines.count == 2 {
                    if dLines.first == "d" {
                        let noQuotes = dLines[1].stringByReplacingOccurrencesOfString("\"", withString: "")
                        pointLines.append(noQuotes)
                    }
                }
            }
        }
    }

    
    

}
