import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!



}

import AppKit

class MessengerCodePicture : NSObject, NSCoding {
    
    var undoManager : NSUndoManager?

    
    private var _nsPicture : NSImage?
    dynamic var nsPicture : NSImage? {
        get {
            return _nsPicture
        }
        set(newValue) {
            guard (_nsPicture != newValue) else { return }
            undoManager?.registerUndoWithTarget(self, selector: Selector("setNsPicture:"), object: _nsPicture)
            undoManager?.setActionName("Change Picture")
        
            _nsPicture = newValue
        
        }
    }
    
    private var _scaleFactor: NSNumber = 1.0
    dynamic var scaleFactor: NSNumber {
        get {
            return _scaleFactor
        }
        set(newValue) {
            guard (_scaleFactor != newValue) else { return }
            undoManager?.registerUndoWithTarget(self, selector: Selector("setScaleFactor:"), object: _scaleFactor)
            undoManager?.setActionName("Change Scale Factor")
            
            _scaleFactor = NSNumber(float: max(0.1, min(newValue.floatValue,10)))
         
        }
    }
    private var _xOffset: NSNumber = 0.0
    dynamic var xOffset : NSNumber {
        get {
            return _xOffset
        }
        set(newValue) {
            guard (_xOffset != newValue) else { return }
            undoManager?.registerUndoWithTarget(self, selector: Selector("setXOffset:"), object: _xOffset)
            undoManager?.setActionName("Change X Offset")
            
            _xOffset = NSNumber(float: max(-1000, min(newValue.floatValue,1000)))
            
        }
    }
    
    private var _yOffset: NSNumber = 0.0
    dynamic var yOffset : NSNumber {
        get {
            return _yOffset
        }
        set(newValue) {
            guard (_yOffset != newValue) else { return }
            undoManager?.registerUndoWithTarget(self, selector: Selector("setYOffset:"), object: _yOffset)
            undoManager?.setActionName("Change Y Offset")
           
            _yOffset = NSNumber(float: max(-1000, min(newValue.floatValue,1000)))
           
        }
    }
    
    @objc
    enum ImageScaling : Int, CustomStringConvertible {
        case FitInSquare
        case None
        
        var description : String {
            switch self {
            case .FitInSquare: return "FitInSquare"
            case .None: return "None"
            }
        }
    }
    private var _scaling : ImageScaling = .FitInSquare
    dynamic var scaling : ImageScaling {
        get {
            return _scaling
        }
        set(newValue) {
            guard (_scaling != newValue) else { return }
            undoManager?.prepareWithInvocationTarget(self).setValue(_scaling.rawValue, forKey: "scaling")
            undoManager?.setActionName("Change Scaling")
            
            _scaling = newValue
            
        }
    }
    
    init(thumbnail: NSImage? = nil, picture: NSImage? = nil, scaleFactor: Double = 1.0, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0, scaling : ImageScaling = .FitInSquare) {
        _nsPicture = picture
        _scaleFactor = scaleFactor
        _xOffset = xOffset
        _yOffset = yOffset
        _scaling = scaling
        super.init()
        commonInit()
        
    }
    
    func commonInit() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let picture = aDecoder.decodeObjectForKey("picture") as? NSImage
        
        let scaleFactor = aDecoder.decodeObjectForKey("scaleFactor") as? Double ?? 1.0
        let xOffset = aDecoder.decodeObjectForKey("xOffset") as? CGFloat ?? 0.0
        let yOffset = aDecoder.decodeObjectForKey("yOffset") as? CGFloat ?? 0.0
        var scaling = ImageScaling.FitInSquare
        if let scalingInt = aDecoder.decodeObjectForKey("scaling") as? Int {
            scaling = ImageScaling.init(rawValue: scalingInt) ?? .FitInSquare
        }
        self.init(thumbnail: nil, picture: picture, scaleFactor: scaleFactor, xOffset: xOffset, yOffset: yOffset, scaling: scaling)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nsPicture, forKey: "picture")
        aCoder.encodeObject(scaleFactor, forKey: "scaleFactor")
        aCoder.encodeObject(xOffset, forKey: "xOffset")
        aCoder.encodeObject(yOffset, forKey: "yOffset")
        aCoder.encodeObject(scaling.rawValue, forKey: "scaling")
    }
    

}


