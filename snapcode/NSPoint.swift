import Foundation

extension NSPoint {
    func sub(p2: NSPoint) -> NSPoint {
        return NSPoint(x: x - p2.x, y: y - p2.y)
    }
    func add(p2: NSPoint) -> NSPoint {
        return NSPoint(x: x + p2.x, y: y + p2.y)
    }
    func distance(p2: NSPoint) -> CGFloat {
        return sqrt((x - p2.x)*(x - p2.x) + (y - p2.y)*(y - p2.y));
    }
    func normal() -> NSPoint {
        let length = sqrt(x*x + y*y);
        return NSPoint(x: x/length, y: y/length);
    }
    func scale(s: CGFloat) -> NSPoint {
        return NSPoint(x: x*s, y: y*s);
    }
}
