import Cocoa

extension NSView {
    
    func isFirstResponder() -> Bool
    {
        return (window?.firstResponder == self) ? true : false;
    }
    
    
    var mousePosition : NSPoint {
        get {
            let screenPoint = NSEvent.mouseLocation()
            let rect = window?.convertRectFromScreen(NSRect(x: screenPoint.x, y: screenPoint.y, width: 1.0, height: 1.0)) ?? NSZeroRect//mozno 1.0, 1.0
            let windowPoint = rect.origin
            let point = convertPoint(windowPoint, fromView:nil)
            return point;
        }
    }
    
}
