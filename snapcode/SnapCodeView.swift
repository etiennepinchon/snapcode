import Cocoa
import Quartz
import Carbon

@IBDesignable
class SnapCodeView : NSView {
    
    let displayFullGrid : Bool = true
    
    var pointCoordinates : [PointCoordinate] = [PointCoordinate]()
    
    var viewTrackingArea : NSTrackingArea?
    
    dynamic var picture : MessengerCodePicture? {
        willSet {
        }
        didSet {
            needsDisplay = true
        }
    }
    
    @IBInspectable dynamic var backgroundColor : NSColor = NSColor.yellowColor() {
        didSet {
            needsDisplay = true
            updateLayerProperties()
        }
    }
    @IBInspectable dynamic var pointColor : NSColor = NSColor.blackColor() {
        didSet {
            needsDisplay = true
        }
    }
    
    var _padding : Int = 10 {
        didSet {
            needsDisplay = true
        }
    }
    
    @IBInspectable var padding : Int = 10
    
    func getCurrentPadding() -> CGFloat {
        return CGFloat(_padding)
    }
    
    private dynamic var codeCenter : CGPoint {
        get {
            return CGPointMake(bounds.width / 2, bounds.width / 2)
        }
    }
    
    private var pictureRadius : Float {
        get {
            return Float(innerGhostPath.bounds.size.width) / 2
            //= 114.947365
        }
    }
    
    private var scale : CGFloat {
        get {
            let originalCodeWidth : CGFloat = 4096.0
            return  CGFloat(bounds.size.width - 2 * getCurrentPadding()) / originalCodeWidth
        }
    }
    
    private var currentContext : CGContext? {
        get {
            //            if available(OSX 10.10, *) {
            return NSGraphicsContext.currentContext()?.CGContext
            //            } else if let contextPointer = NSGraphicsContext.currentContext()?.graphicsPort {
            //                let opaquePointer = COpaquePointer(contextPointer)
            //                let context: CGContextRef = Unmanaged.fromOpaque(opaquePointer).takeUnretainedValue()
            //                return context
            //            }
            
            //            return nil
        }
    }
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let svg2 : String = try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("snapcode", ofType: "svg")!, encoding: NSUTF8StringEncoding) as String
        let parser2 = SVGParser(svg: svg2)
        parser2.parse()
        pointCoordinates = parser2.pointCoordinates
        self.picture = MessengerCodePicture(picture: NSImage(named: "chat"))
        setupLayerBorder()
    }
    
    func setupLayerBorder() {
        wantsLayer = true
        //        layer!.borderColor = NSColor.whiteColor().CGColor
        //        layer!.borderWidth = 0.0;
        layer!.cornerRadius = 8.0;
        layer!.masksToBounds = true;
    }
    
    func updateLayerProperties() {
        layer!.borderColor = backgroundColor.CGColor
    }
    
    let checkerboardImage : NSImage = NSImage.checkerboardImageWithSize(16.0)
    
    func drawBackground() {
        CGContextSaveGState(currentContext!)
        if (NSGraphicsContext.currentContextDrawingToScreen()) {
            NSColor(patternImage: checkerboardImage).set()
            NSRectFillUsingOperation(bounds, NSCompositingOperation.SourceOver)
        }
        backgroundColor.setFill()
//        NSRectFillUsingOperation(bounds, NSCompositingOperation.SourceOver)
        CGContextRestoreGState(currentContext!)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        NSGraphicsContext.saveGraphicsState()
        drawBackground()

        let transform = NSAffineTransform()
        transform.scaleXBy(scale, yBy: scale)
        transform.translateXBy(getCurrentPadding() / scale, yBy: getCurrentPadding() / scale)
        transform.concat()
        
        drawRoundedRectWithGhostShape()
        drawRectFillWithGhostShape()
        drawInnerGhost()
        drawPoints()
        drawPicture()
        NSGraphicsContext.restoreGraphicsState()
    }
    
    func drawRectFillWithGhostShape() {
    
        //// Bezier 2 Drawing
        let bezier2Path = NSBezierPath()
        bezier2Path.moveToPoint(NSMakePoint(76.8, 3440.64))
        bezier2Path.curveToPoint(NSMakePoint(655.36, 4019.2), controlPoint1: NSMakePoint(76.8, 3760.12), controlPoint2: NSMakePoint(335.88, 4019.2))
        bezier2Path.lineToPoint(NSMakePoint(3440.64, 4019.2))
        bezier2Path.curveToPoint(NSMakePoint(4019.2, 3440.64), controlPoint1: NSMakePoint(3760.12, 4019.2), controlPoint2: NSMakePoint(4019.2, 3760.12))
        bezier2Path.lineToPoint(NSMakePoint(4019.2, 655.36))
        bezier2Path.curveToPoint(NSMakePoint(3440.64, 76.8), controlPoint1: NSMakePoint(4019.2, 335.88), controlPoint2: NSMakePoint(3760.12, 76.8))
        bezier2Path.lineToPoint(NSMakePoint(655.36, 76.8))
        bezier2Path.curveToPoint(NSMakePoint(76.8, 655.36), controlPoint1: NSMakePoint(335.88, 76.8), controlPoint2: NSMakePoint(76.8, 335.88))
        bezier2Path.lineToPoint(NSMakePoint(76.8, 3440.64))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(NSMakePoint(2076.52, 3434))
        bezier2Path.curveToPoint(NSMakePoint(1788.8, 3400.68), controlPoint1: NSMakePoint(1978.64, 3433.56), controlPoint2: NSMakePoint(1883.6, 3427.56))
        bezier2Path.curveToPoint(NSMakePoint(1402.2, 3149.08), controlPoint1: NSMakePoint(1637.64, 3357.8), controlPoint2: NSMakePoint(1501.28, 3271.64))
        bezier2Path.curveToPoint(NSMakePoint(1264.48, 2887.28), controlPoint1: NSMakePoint(1340.8, 3073.16), controlPoint2: NSMakePoint(1287.44, 2982.84))
        bezier2Path.curveToPoint(NSMakePoint(1242.48, 2559.68), controlPoint1: NSMakePoint(1238.92, 2780.8), controlPoint2: NSMakePoint(1239.12, 2668.48))
        bezier2Path.curveToPoint(NSMakePoint(1251.2, 2387.4), controlPoint1: NSMakePoint(1244.24, 2502.2), controlPoint2: NSMakePoint(1247.6, 2444.8))
        bezier2Path.curveToPoint(NSMakePoint(1253.84, 2345.84), controlPoint1: NSMakePoint(1252.08, 2373.52), controlPoint2: NSMakePoint(1252.96, 2359.68))
        bezier2Path.curveToPoint(NSMakePoint(1255.64, 2294.84), controlPoint1: NSMakePoint(1254.44, 2336.52), controlPoint2: NSMakePoint(1261.2, 2301.2))
        bezier2Path.curveToPoint(NSMakePoint(1192.16, 2283.12), controlPoint1: NSMakePoint(1244.04, 2281.64), controlPoint2: NSMakePoint(1207.16, 2282.56))
        bezier2Path.curveToPoint(NSMakePoint(1113.28, 2299.16), controlPoint1: NSMakePoint(1165.24, 2284.12), controlPoint2: NSMakePoint(1138.68, 2290.52))
        bezier2Path.curveToPoint(NSMakePoint(1029.8, 2328.24), controlPoint1: NSMakePoint(1085.56, 2308.6), controlPoint2: NSMakePoint(1059.36, 2325.36))
        bezier2Path.curveToPoint(NSMakePoint(900.24, 2279.72), controlPoint1: NSMakePoint(983.48, 2332.72), controlPoint2: NSMakePoint(932.2, 2313.52))
        bezier2Path.curveToPoint(NSMakePoint(936.44, 2115.44), controlPoint1: NSMakePoint(845.92, 2222.24), controlPoint2: NSMakePoint(880.36, 2154.4))
        bezier2Path.curveToPoint(NSMakePoint(1085.32, 2050.48), controlPoint1: NSMakePoint(981.72, 2084), controlPoint2: NSMakePoint(1033.52, 2067.52))
        bezier2Path.curveToPoint(NSMakePoint(1208, 1987.68), controlPoint1: NSMakePoint(1128.16, 2036.4), controlPoint2: NSMakePoint(1175.32, 2020.12))
        bezier2Path.curveToPoint(NSMakePoint(1203.8, 1826.16), controlPoint1: NSMakePoint(1255.72, 1940.32), controlPoint2: NSMakePoint(1229, 1877.92))
        bezier2Path.curveToPoint(NSMakePoint(1136.24, 1709.84), controlPoint1: NSMakePoint(1184.16, 1785.84), controlPoint2: NSMakePoint(1161.24, 1747.08))
        bezier2Path.curveToPoint(NSMakePoint(798.36, 1406.08), controlPoint1: NSMakePoint(1051.08, 1583.12), controlPoint2: NSMakePoint(937.52, 1471.72))
        bezier2Path.curveToPoint(NSMakePoint(667.36, 1360.32), controlPoint1: NSMakePoint(756.44, 1386.32), controlPoint2: NSMakePoint(712.52, 1370.88))
        bezier2Path.curveToPoint(NSMakePoint(599.2, 1341.36), controlPoint1: NSMakePoint(645.2, 1355.12), controlPoint2: NSMakePoint(618.24, 1354.8))
        bezier2Path.curveToPoint(NSMakePoint(574.84, 1276.96), controlPoint1: NSMakePoint(578.48, 1326.72), controlPoint2: NSMakePoint(569.96, 1301.44))
        bezier2Path.curveToPoint(NSMakePoint(714.68, 1162.56), controlPoint1: NSMakePoint(587.28, 1214.6), controlPoint2: NSMakePoint(662, 1182.16))
        bezier2Path.curveToPoint(NSMakePoint(858.08, 1122.76), controlPoint1: NSMakePoint(761.2, 1145.24), controlPoint2: NSMakePoint(809.6, 1133))
        bezier2Path.curveToPoint(NSMakePoint(947.2, 1106.2), controlPoint1: NSMakePoint(887.64, 1116.52), controlPoint2: NSMakePoint(917.4, 1111.08))
        bezier2Path.curveToPoint(NSMakePoint(973.72, 1090.72), controlPoint1: NSMakePoint(961.76, 1103.8), controlPoint2: NSMakePoint(968.4, 1104.8))
        bezier2Path.curveToPoint(NSMakePoint(983.2, 1057.08), controlPoint1: NSMakePoint(977.84, 1079.84), controlPoint2: NSMakePoint(980.48, 1068.4))
        bezier2Path.curveToPoint(NSMakePoint(1002.76, 973.68), controlPoint1: NSMakePoint(989.84, 1029.28), controlPoint2: NSMakePoint(995.16, 1001.2))
        bezier2Path.curveToPoint(NSMakePoint(1029.52, 926.4), controlPoint1: NSMakePoint(1007.76, 955.6), controlPoint2: NSMakePoint(1014.28, 938.4))
        bezier2Path.curveToPoint(NSMakePoint(1175.2, 927.12), controlPoint1: NSMakePoint(1068.96, 895.36), controlPoint2: NSMakePoint(1131.36, 919.32))
        bezier2Path.curveToPoint(NSMakePoint(1525.2, 886.56), controlPoint1: NSMakePoint(1292.24, 947.92), controlPoint2: NSMakePoint(1419.8, 947.2))
        bezier2Path.curveToPoint(NSMakePoint(1791.6, 716.8), controlPoint1: NSMakePoint(1616.76, 833.92), controlPoint2: NSMakePoint(1695.8, 762.6))
        bezier2Path.curveToPoint(NSMakePoint(2118, 664.44), controlPoint1: NSMakePoint(1893.48, 668.08), controlPoint2: NSMakePoint(2006.08, 654.04))
        bezier2Path.curveToPoint(NSMakePoint(2404.64, 774.64), controlPoint1: NSMakePoint(2222.84, 674.2), controlPoint2: NSMakePoint(2317.64, 717.24))
        bezier2Path.curveToPoint(NSMakePoint(2703.76, 932.72), controlPoint1: NSMakePoint(2499.64, 837.32), controlPoint2: NSMakePoint(2587, 916.88))
        bezier2Path.curveToPoint(NSMakePoint(2895.2, 932), controlPoint1: NSMakePoint(2767.32, 941.32), controlPoint2: NSMakePoint(2831.72, 940.84))
        bezier2Path.curveToPoint(NSMakePoint(3029.68, 914.4), controlPoint1: NSMakePoint(2939.2, 925.88), controlPoint2: NSMakePoint(2984.96, 910.52))
        bezier2Path.curveToPoint(NSMakePoint(3107.24, 1033.56), controlPoint1: NSMakePoint(3090.36, 919.72), controlPoint2: NSMakePoint(3096.72, 985.76))
        bezier2Path.curveToPoint(NSMakePoint(3124.92, 1098.04), controlPoint1: NSMakePoint(3111.48, 1052.8), controlPoint2: NSMakePoint(3113.4, 1081.56))
        bezier2Path.curveToPoint(NSMakePoint(3162.36, 1108.68), controlPoint1: NSMakePoint(3131.68, 1107.72), controlPoint2: NSMakePoint(3150.72, 1106.72))
        bezier2Path.curveToPoint(NSMakePoint(3211.12, 1117.56), controlPoint1: NSMakePoint(3178.64, 1111.44), controlPoint2: NSMakePoint(3194.88, 1114.4))
        bezier2Path.curveToPoint(NSMakePoint(3463.4, 1203), controlPoint1: NSMakePoint(3296.16, 1134.16), controlPoint2: NSMakePoint(3390.28, 1153.72))
        bezier2Path.curveToPoint(NSMakePoint(3515.28, 1259.24), controlPoint1: NSMakePoint(3484.56, 1217.28), controlPoint2: NSMakePoint(3504.76, 1235.48))
        bezier2Path.curveToPoint(NSMakePoint(3510.6, 1327.68), controlPoint1: NSMakePoint(3525.16, 1281.56), controlPoint2: NSMakePoint(3525.48, 1307.48))
        bezier2Path.curveToPoint(NSMakePoint(3448.4, 1356), controlPoint1: NSMakePoint(3495.04, 1348.84), controlPoint2: NSMakePoint(3472.28, 1351.2))
        bezier2Path.curveToPoint(NSMakePoint(3200.04, 1462.04), controlPoint1: NSMakePoint(3359.32, 1373.92), controlPoint2: NSMakePoint(3275, 1410.92))
        bezier2Path.curveToPoint(NSMakePoint(2922.48, 1769.2), controlPoint1: NSMakePoint(3085.16, 1540.36), controlPoint2: NSMakePoint(2991.96, 1649.36))
        bezier2Path.curveToPoint(NSMakePoint(2882.8, 1845.96), controlPoint1: NSMakePoint(2908, 1794.16), controlPoint2: NSMakePoint(2894.84, 1819.72))
        bezier2Path.curveToPoint(NSMakePoint(2876.36, 1974.36), controlPoint1: NSMakePoint(2864.24, 1886.44), controlPoint2: NSMakePoint(2847.48, 1934.32))
        bezier2Path.curveToPoint(NSMakePoint(2992.36, 2044.28), controlPoint1: NSMakePoint(2902.96, 2011.24), controlPoint2: NSMakePoint(2951.04, 2029.76))
        bezier2Path.curveToPoint(NSMakePoint(3141.32, 2103.72), controlPoint1: NSMakePoint(3043.16, 2062.12), controlPoint2: NSMakePoint(3094.56, 2076.04))
        bezier2Path.curveToPoint(NSMakePoint(3221.08, 2192.96), controlPoint1: NSMakePoint(3175.44, 2123.92), controlPoint2: NSMakePoint(3211.28, 2152.48))
        bezier2Path.curveToPoint(NSMakePoint(3015.68, 2319.2), controlPoint1: NSMakePoint(3246.76, 2299.32), controlPoint2: NSMakePoint(3094.72, 2353.16))
        bezier2Path.curveToPoint(NSMakePoint(2853.84, 2289.16), controlPoint1: NSMakePoint(2966.88, 2298.24), controlPoint2: NSMakePoint(2907.6, 2271.36))
        bezier2Path.curveToPoint(NSMakePoint(2841.68, 2294.08), controlPoint1: NSMakePoint(2850.36, 2290.32), controlPoint2: NSMakePoint(2844.24, 2291.44))
        bezier2Path.curveToPoint(NSMakePoint(2840.04, 2312.52), controlPoint1: NSMakePoint(2837.36, 2298.52), controlPoint2: NSMakePoint(2839.64, 2305.64))
        bezier2Path.curveToPoint(NSMakePoint(2842.92, 2359.24), controlPoint1: NSMakePoint(2840.96, 2328.08), controlPoint2: NSMakePoint(2841.96, 2343.64))
        bezier2Path.curveToPoint(NSMakePoint(2847.4, 2431.48), controlPoint1: NSMakePoint(2844.4, 2383.32), controlPoint2: NSMakePoint(2845.96, 2407.4))
        bezier2Path.curveToPoint(NSMakePoint(2849.24, 2774), controlPoint1: NSMakePoint(2854.12, 2545.32), controlPoint2: NSMakePoint(2859.6, 2660.2))
        bezier2Path.curveToPoint(NSMakePoint(2821.4, 2923.76), controlPoint1: NSMakePoint(2844.64, 2824.56), controlPoint2: NSMakePoint(2836.92, 2875.32))
        bezier2Path.curveToPoint(NSMakePoint(2757.08, 3058.48), controlPoint1: NSMakePoint(2806.28, 2971), controlPoint2: NSMakePoint(2782.56, 3016.04))
        bezier2Path.curveToPoint(NSMakePoint(2576.2, 3265.44), controlPoint1: NSMakePoint(2709.64, 3137.56), controlPoint2: NSMakePoint(2648.72, 3208.36))
        bezier2Path.curveToPoint(NSMakePoint(2197.48, 3424.56), controlPoint1: NSMakePoint(2467.04, 3351.36), controlPoint2: NSMakePoint(2334.44, 3404.08))
        bezier2Path.curveToPoint(NSMakePoint(2076.52, 3434), controlPoint1: NSMakePoint(2157.52, 3430.6), controlPoint2: NSMakePoint(2117, 3434))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4
        backgroundColor.setFill()
        bezier2Path.fill()
    }
    
    
    func drawRoundedRectWithGhostShape() {
    
        let roundedRectWithGhost = NSBezierPath()
        roundedRectWithGhost.moveToPoint(NSMakePoint(2076.52, 3372.84))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2392.84, 3305.08), controlPoint1: NSMakePoint(2184.68, 3372.84), controlPoint2: NSMakePoint(2294.2, 3349.32))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2755.6, 2926.68), controlPoint1: NSMakePoint(2556.16, 3231.84), controlPoint2: NSMakePoint(2689.56, 3093.6))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2793.64, 2619.8), controlPoint1: NSMakePoint(2793.4, 2831.12), controlPoint2: NSMakePoint(2794.52, 2721.08))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2787, 2444.68), controlPoint1: NSMakePoint(2793.12, 2561.36), controlPoint2: NSMakePoint(2790.36, 2503))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2781.6, 2356.76), controlPoint1: NSMakePoint(2785.28, 2415.36), controlPoint2: NSMakePoint(2783.44, 2386.08))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2778.64, 2308.52), controlPoint1: NSMakePoint(2780.6, 2340.68), controlPoint2: NSMakePoint(2779.6, 2324.6))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2776.72, 2273.96), controlPoint1: NSMakePoint(2778.04, 2298.16), controlPoint2: NSMakePoint(2774.44, 2284.16))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2836.96, 2230.36), controlPoint1: NSMakePoint(2781.72, 2251.52), controlPoint2: NSMakePoint(2817.32, 2236.56))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2993, 2243.6), controlPoint1: NSMakePoint(2888.84, 2214.04), controlPoint2: NSMakePoint(2943.08, 2225.8))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3082.2, 2268.96), controlPoint1: NSMakePoint(3022.76, 2254.2), controlPoint2: NSMakePoint(3049.56, 2271.96))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3150.08, 2239.12), controlPoint1: NSMakePoint(3105.84, 2266.8), controlPoint2: NSMakePoint(3133.24, 2256.24))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3148.84, 2186.12), controlPoint1: NSMakePoint(3167.76, 2221.12), controlPoint2: NSMakePoint(3164.04, 2203.36))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3031.96, 2121.44), controlPoint1: NSMakePoint(3119.96, 2153.36), controlPoint2: NSMakePoint(3072.28, 2134.72))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2901.84, 2071.88), controlPoint1: NSMakePoint(2987.8, 2106.92), controlPoint2: NSMakePoint(2943, 2094))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2807.84, 1974.2), controlPoint1: NSMakePoint(2861.28, 2050.08), controlPoint2: NSMakePoint(2823.84, 2018.72))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2826.64, 1821.88), controlPoint1: NSMakePoint(2789.24, 1922.44), controlPoint2: NSMakePoint(2804.76, 1869.8))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2968.52, 1594.76), controlPoint1: NSMakePoint(2863.8, 1740.48), controlPoint2: NSMakePoint(2912.08, 1664.2))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3373.72, 1311.56), controlPoint1: NSMakePoint(3074.04, 1464.92), controlPoint2: NSMakePoint(3211.96, 1359.6))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3445.92, 1294.12), controlPoint1: NSMakePoint(3397.48, 1304.52), controlPoint2: NSMakePoint(3421.56, 1298.68))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3459.28, 1283.56), controlPoint1: NSMakePoint(3456.24, 1292.2), controlPoint2: NSMakePoint(3462.92, 1294.56))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3457.12, 1279.6), controlPoint1: NSMakePoint(3458.8, 1282.16), controlPoint2: NSMakePoint(3457.84, 1280.84))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3434.48, 1257.2), controlPoint1: NSMakePoint(3451.72, 1270.56), controlPoint2: NSMakePoint(3442.88, 1263.32))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3267.68, 1192.48), controlPoint1: NSMakePoint(3386.8, 1222.32), controlPoint2: NSMakePoint(3324, 1206.28))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3187.2, 1175.2), controlPoint1: NSMakePoint(3241.04, 1185.92), controlPoint2: NSMakePoint(3214.16, 1180.28))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3102.72, 1159.16), controlPoint1: NSMakePoint(3160.4, 1170.16), controlPoint2: NSMakePoint(3127.76, 1170.04))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3046.16, 1040.2), controlPoint1: NSMakePoint(3060.92, 1141.04), controlPoint2: NSMakePoint(3054.68, 1078.68))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3035.4, 995.28), controlPoint1: NSMakePoint(3042.84, 1025.16), controlPoint2: NSMakePoint(3039.4, 1010.16))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3018.84, 975.12), controlPoint1: NSMakePoint(3031.84, 982.08), controlPoint2: NSMakePoint(3032.92, 975.32))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2946.76, 985.48), controlPoint1: NSMakePoint(2994.68, 974.72), controlPoint2: NSMakePoint(2970.36, 981.12))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2778.32, 999.84), controlPoint1: NSMakePoint(2891.2, 995.72), controlPoint2: NSMakePoint(2834.84, 1001.2))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2596.08, 967.36), controlPoint1: NSMakePoint(2716.56, 998.36), controlPoint2: NSMakePoint(2653.48, 991.24))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2443.68, 875.84), controlPoint1: NSMakePoint(2541.16, 944.48), controlPoint2: NSMakePoint(2492.04, 909.96))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2170.6, 734.28), controlPoint1: NSMakePoint(2359.16, 816.2), controlPoint2: NSMakePoint(2273.32, 757.04))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2013.36, 723.36), controlPoint1: NSMakePoint(2119.12, 722.88), controlPoint2: NSMakePoint(2065.88, 721.68))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1850.24, 757.64), controlPoint1: NSMakePoint(1957.36, 725.16), controlPoint2: NSMakePoint(1902.2, 736.8))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1581.16, 924.08), controlPoint1: NSMakePoint(1751.16, 797.4), controlPoint2: NSMakePoint(1670.56, 867.76))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1416.72, 990.8), controlPoint1: NSMakePoint(1530.36, 956.08), controlPoint2: NSMakePoint(1476.4, 981.44))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1225.28, 995.96), controlPoint1: NSMakePoint(1353.4, 1000.76), controlPoint2: NSMakePoint(1289.04, 1002.76))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1151.48, 984.8), controlPoint1: NSMakePoint(1200.52, 993.32), controlPoint2: NSMakePoint(1175.96, 989.4))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1077.08, 972.8), controlPoint1: NSMakePoint(1127.52, 980.32), controlPoint2: NSMakePoint(1101.6, 971.84))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1062.32, 987.6), controlPoint1: NSMakePoint(1065.52, 973.28), controlPoint2: NSMakePoint(1065.4, 976.76))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1050.48, 1036.4), controlPoint1: NSMakePoint(1057.8, 1003.72), controlPoint2: NSMakePoint(1054.08, 1020.04))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1031.32, 1111.04), controlPoint1: NSMakePoint(1044.96, 1061.4), controlPoint2: NSMakePoint(1040.32, 1087))
        roundedRectWithGhost.curveToPoint(NSMakePoint(995.04, 1158.08), controlPoint1: NSMakePoint(1024.28, 1129.84), controlPoint2: NSMakePoint(1013.88, 1149))
        roundedRectWithGhost.curveToPoint(NSMakePoint(911.84, 1174.36), controlPoint1: NSMakePoint(970.96, 1169.68), controlPoint2: NSMakePoint(938, 1169.44))
        roundedRectWithGhost.curveToPoint(NSMakePoint(767.2, 1209.24), controlPoint1: NSMakePoint(863.12, 1183.48), controlPoint2: NSMakePoint(814.52, 1194.28))
        roundedRectWithGhost.curveToPoint(NSMakePoint(646.96, 1269.4), controlPoint1: NSMakePoint(726.56, 1222.08), controlPoint2: NSMakePoint(677.56, 1237.72))
        roundedRectWithGhost.curveToPoint(NSMakePoint(639, 1279.2), controlPoint1: NSMakePoint(644.04, 1272.4), controlPoint2: NSMakePoint(641.16, 1275.6))
        roundedRectWithGhost.curveToPoint(NSMakePoint(636.88, 1282.96), controlPoint1: NSMakePoint(638.28, 1280.36), controlPoint2: NSMakePoint(637.28, 1281.64))
        roundedRectWithGhost.curveToPoint(NSMakePoint(647.48, 1293.6), controlPoint1: NSMakePoint(633.56, 1293.16), controlPoint2: NSMakePoint(637.52, 1291.76))
        roundedRectWithGhost.curveToPoint(NSMakePoint(785.12, 1333.4), controlPoint1: NSMakePoint(694.56, 1302.24), controlPoint2: NSMakePoint(740.72, 1315.56))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1007.4, 1470.48), controlPoint1: NSMakePoint(866.4, 1365.96), controlPoint2: NSMakePoint(941.2, 1413.32))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1244.88, 1771.88), controlPoint1: NSMakePoint(1104.52, 1554.28), controlPoint2: NSMakePoint(1184.92, 1658.6))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1294.28, 1896.2), controlPoint1: NSMakePoint(1265.36, 1810.6), controlPoint2: NSMakePoint(1287.36, 1852.96))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1132.24, 2098.96), controlPoint1: NSMakePoint(1311.68, 2004.76), controlPoint2: NSMakePoint(1222.32, 2066.2))
        roundedRectWithGhost.curveToPoint(NSMakePoint(990.44, 2153.64), controlPoint1: NSMakePoint(1084.4, 2116.36), controlPoint2: NSMakePoint(1035.08, 2128.28))
        roundedRectWithGhost.curveToPoint(NSMakePoint(933.6, 2217.12), controlPoint1: NSMakePoint(970.08, 2165.2), controlPoint2: NSMakePoint(930.52, 2188.28))
        roundedRectWithGhost.curveToPoint(NSMakePoint(981.16, 2260.64), controlPoint1: NSMakePoint(935.92, 2239.04), controlPoint2: NSMakePoint(963.04, 2253.84))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1020.12, 2267.52), controlPoint1: NSMakePoint(993.44, 2265.24), controlPoint2: NSMakePoint(1006.92, 2268.24))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1064.08, 2252.32), controlPoint1: NSMakePoint(1036, 2266.64), controlPoint2: NSMakePoint(1049.6, 2258.24))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1232.64, 2224.28), controlPoint1: NSMakePoint(1116.68, 2230.76), controlPoint2: NSMakePoint(1175.52, 2215.4))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1311.4, 2260.6), controlPoint1: NSMakePoint(1261.2, 2228.72), controlPoint2: NSMakePoint(1290.8, 2239.56))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1319.32, 2273.96), controlPoint1: NSMakePoint(1316.36, 2265.68), controlPoint2: NSMakePoint(1318.2, 2267.8))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1317.2, 2311.84), controlPoint1: NSMakePoint(1321.36, 2285.32), controlPoint2: NSMakePoint(1317.84, 2300.48))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1311.56, 2402.8), controlPoint1: NSMakePoint(1315.4, 2342.16), controlPoint2: NSMakePoint(1313.44, 2372.48))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1306.08, 2750.76), controlPoint1: NSMakePoint(1304.4, 2518.44), controlPoint2: NSMakePoint(1297.48, 2635))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1330.72, 2898.24), controlPoint1: NSMakePoint(1309.76, 2800.4), controlPoint2: NSMakePoint(1316.24, 2850.48))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1395.08, 3032.84), controlPoint1: NSMakePoint(1345.12, 2945.68), controlPoint2: NSMakePoint(1369.24, 2990.72))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1578.32, 3232.56), controlPoint1: NSMakePoint(1442.72, 3110.44), controlPoint2: NSMakePoint(1504.6, 3178.96))
        roundedRectWithGhost.curveToPoint(NSMakePoint(1949.36, 3368.88), controlPoint1: NSMakePoint(1686.36, 3311.16), controlPoint2: NSMakePoint(1816.8, 3356.24))
        roundedRectWithGhost.curveToPoint(NSMakePoint(2076.52, 3372.84), controlPoint1: NSMakePoint(1991.56, 3372.92), controlPoint2: NSMakePoint(2034.12, 3372.84))
        roundedRectWithGhost.closePath()
        roundedRectWithGhost.moveToPoint(NSMakePoint(0, 655.36))
        roundedRectWithGhost.curveToPoint(NSMakePoint(655.36, 0), controlPoint1: NSMakePoint(0, 293.44), controlPoint2: NSMakePoint(293.44, 0))
        roundedRectWithGhost.lineToPoint(NSMakePoint(3440.64, 0))
        roundedRectWithGhost.curveToPoint(NSMakePoint(4096, 655.36), controlPoint1: NSMakePoint(3802.56, 0), controlPoint2: NSMakePoint(4096, 293.44))
        roundedRectWithGhost.lineToPoint(NSMakePoint(4096, 3440.64))
        roundedRectWithGhost.curveToPoint(NSMakePoint(3440.64, 4096), controlPoint1: NSMakePoint(4096, 3802.56), controlPoint2: NSMakePoint(3802.56, 4096))
        roundedRectWithGhost.lineToPoint(NSMakePoint(655.36, 4096))
        roundedRectWithGhost.curveToPoint(NSMakePoint(0, 3440.64), controlPoint1: NSMakePoint(293.44, 4096), controlPoint2: NSMakePoint(0, 3802.56))
        roundedRectWithGhost.lineToPoint(NSMakePoint(0, 655.36))
        roundedRectWithGhost.closePath()
        roundedRectWithGhost.miterLimit = 4
        NSColor.blackColor().setFill()
        roundedRectWithGhost.fill()
    }
    
    func drawInnerGhost() {
        
        innerGhostPath.miterLimit = 4
        NSColor.whiteColor().setFill()
        innerGhostPath.fill()
    }
    
    var innerGhostPath : NSBezierPath {
    
        get {
            let innerGhost = NSBezierPath()
            innerGhost.moveToPoint(NSMakePoint(2076.52, 3372.84))
            innerGhost.curveToPoint(NSMakePoint(2392.84, 3305.08), controlPoint1: NSMakePoint(2184.68, 3372.84), controlPoint2: NSMakePoint(2294.2, 3349.32))
            innerGhost.curveToPoint(NSMakePoint(2755.6, 2926.68), controlPoint1: NSMakePoint(2556.16, 3231.84), controlPoint2: NSMakePoint(2689.56, 3093.6))
            innerGhost.curveToPoint(NSMakePoint(2793.64, 2619.8), controlPoint1: NSMakePoint(2793.4, 2831.12), controlPoint2: NSMakePoint(2794.52, 2721.08))
            innerGhost.curveToPoint(NSMakePoint(2787, 2444.68), controlPoint1: NSMakePoint(2793.12, 2561.36), controlPoint2: NSMakePoint(2790.36, 2503))
            innerGhost.curveToPoint(NSMakePoint(2781.6, 2356.76), controlPoint1: NSMakePoint(2785.28, 2415.36), controlPoint2: NSMakePoint(2783.44, 2386.08))
            innerGhost.curveToPoint(NSMakePoint(2778.64, 2308.52), controlPoint1: NSMakePoint(2780.6, 2340.68), controlPoint2: NSMakePoint(2779.6, 2324.6))
            innerGhost.curveToPoint(NSMakePoint(2776.72, 2273.96), controlPoint1: NSMakePoint(2778.04, 2298.16), controlPoint2: NSMakePoint(2774.44, 2284.16))
            innerGhost.curveToPoint(NSMakePoint(2836.96, 2230.36), controlPoint1: NSMakePoint(2781.72, 2251.52), controlPoint2: NSMakePoint(2817.32, 2236.56))
            innerGhost.curveToPoint(NSMakePoint(2993, 2243.6), controlPoint1: NSMakePoint(2888.84, 2214.04), controlPoint2: NSMakePoint(2943.08, 2225.8))
            innerGhost.curveToPoint(NSMakePoint(3082.2, 2268.96), controlPoint1: NSMakePoint(3022.76, 2254.2), controlPoint2: NSMakePoint(3049.56, 2271.96))
            innerGhost.curveToPoint(NSMakePoint(3150.08, 2239.12), controlPoint1: NSMakePoint(3105.84, 2266.8), controlPoint2: NSMakePoint(3133.24, 2256.24))
            innerGhost.curveToPoint(NSMakePoint(3148.84, 2186.12), controlPoint1: NSMakePoint(3167.76, 2221.12), controlPoint2: NSMakePoint(3164.04, 2203.36))
            innerGhost.curveToPoint(NSMakePoint(3031.96, 2121.44), controlPoint1: NSMakePoint(3119.96, 2153.36), controlPoint2: NSMakePoint(3072.28, 2134.72))
            innerGhost.curveToPoint(NSMakePoint(2901.84, 2071.88), controlPoint1: NSMakePoint(2987.8, 2106.92), controlPoint2: NSMakePoint(2943, 2094))
            innerGhost.curveToPoint(NSMakePoint(2807.84, 1974.2), controlPoint1: NSMakePoint(2861.28, 2050.08), controlPoint2: NSMakePoint(2823.84, 2018.72))
            innerGhost.curveToPoint(NSMakePoint(2826.64, 1821.88), controlPoint1: NSMakePoint(2789.24, 1922.44), controlPoint2: NSMakePoint(2804.76, 1869.8))
            innerGhost.curveToPoint(NSMakePoint(2968.52, 1594.76), controlPoint1: NSMakePoint(2863.8, 1740.48), controlPoint2: NSMakePoint(2912.08, 1664.2))
            innerGhost.curveToPoint(NSMakePoint(3373.72, 1311.56), controlPoint1: NSMakePoint(3074.04, 1464.92), controlPoint2: NSMakePoint(3211.96, 1359.6))
            innerGhost.curveToPoint(NSMakePoint(3445.92, 1294.12), controlPoint1: NSMakePoint(3397.48, 1304.52), controlPoint2: NSMakePoint(3421.56, 1298.68))
            innerGhost.curveToPoint(NSMakePoint(3459.28, 1283.56), controlPoint1: NSMakePoint(3456.24, 1292.2), controlPoint2: NSMakePoint(3462.92, 1294.56))
            innerGhost.curveToPoint(NSMakePoint(3457.12, 1279.6), controlPoint1: NSMakePoint(3458.8, 1282.16), controlPoint2: NSMakePoint(3457.84, 1280.84))
            innerGhost.curveToPoint(NSMakePoint(3434.48, 1257.2), controlPoint1: NSMakePoint(3451.72, 1270.56), controlPoint2: NSMakePoint(3442.88, 1263.32))
            innerGhost.curveToPoint(NSMakePoint(3267.68, 1192.48), controlPoint1: NSMakePoint(3386.8, 1222.32), controlPoint2: NSMakePoint(3324, 1206.28))
            innerGhost.curveToPoint(NSMakePoint(3187.2, 1175.2), controlPoint1: NSMakePoint(3241.04, 1185.92), controlPoint2: NSMakePoint(3214.16, 1180.28))
            innerGhost.curveToPoint(NSMakePoint(3102.72, 1159.16), controlPoint1: NSMakePoint(3160.4, 1170.16), controlPoint2: NSMakePoint(3127.76, 1170.04))
            innerGhost.curveToPoint(NSMakePoint(3046.16, 1040.2), controlPoint1: NSMakePoint(3060.92, 1141.04), controlPoint2: NSMakePoint(3054.68, 1078.68))
            innerGhost.curveToPoint(NSMakePoint(3035.4, 995.28), controlPoint1: NSMakePoint(3042.84, 1025.16), controlPoint2: NSMakePoint(3039.4, 1010.16))
            innerGhost.curveToPoint(NSMakePoint(3018.84, 975.12), controlPoint1: NSMakePoint(3031.84, 982.08), controlPoint2: NSMakePoint(3032.92, 975.32))
            innerGhost.curveToPoint(NSMakePoint(2946.76, 985.48), controlPoint1: NSMakePoint(2994.68, 974.72), controlPoint2: NSMakePoint(2970.36, 981.12))
            innerGhost.curveToPoint(NSMakePoint(2778.32, 999.84), controlPoint1: NSMakePoint(2891.2, 995.72), controlPoint2: NSMakePoint(2834.84, 1001.2))
            innerGhost.curveToPoint(NSMakePoint(2596.08, 967.36), controlPoint1: NSMakePoint(2716.56, 998.36), controlPoint2: NSMakePoint(2653.48, 991.24))
            innerGhost.curveToPoint(NSMakePoint(2443.68, 875.84), controlPoint1: NSMakePoint(2541.16, 944.48), controlPoint2: NSMakePoint(2492.04, 909.96))
            innerGhost.curveToPoint(NSMakePoint(2170.6, 734.28), controlPoint1: NSMakePoint(2359.16, 816.2), controlPoint2: NSMakePoint(2273.32, 757.04))
            innerGhost.curveToPoint(NSMakePoint(2013.36, 723.36), controlPoint1: NSMakePoint(2119.12, 722.88), controlPoint2: NSMakePoint(2065.88, 721.68))
            innerGhost.curveToPoint(NSMakePoint(1850.24, 757.64), controlPoint1: NSMakePoint(1957.36, 725.16), controlPoint2: NSMakePoint(1902.2, 736.8))
            innerGhost.curveToPoint(NSMakePoint(1581.16, 924.08), controlPoint1: NSMakePoint(1751.16, 797.4), controlPoint2: NSMakePoint(1670.56, 867.76))
            innerGhost.curveToPoint(NSMakePoint(1416.72, 990.8), controlPoint1: NSMakePoint(1530.36, 956.08), controlPoint2: NSMakePoint(1476.4, 981.44))
            innerGhost.curveToPoint(NSMakePoint(1225.28, 995.96), controlPoint1: NSMakePoint(1353.4, 1000.76), controlPoint2: NSMakePoint(1289.04, 1002.76))
            innerGhost.curveToPoint(NSMakePoint(1151.48, 984.8), controlPoint1: NSMakePoint(1200.52, 993.32), controlPoint2: NSMakePoint(1175.96, 989.4))
            innerGhost.curveToPoint(NSMakePoint(1077.08, 972.8), controlPoint1: NSMakePoint(1127.52, 980.32), controlPoint2: NSMakePoint(1101.6, 971.84))
            innerGhost.curveToPoint(NSMakePoint(1062.32, 987.6), controlPoint1: NSMakePoint(1065.52, 973.28), controlPoint2: NSMakePoint(1065.4, 976.76))
            innerGhost.curveToPoint(NSMakePoint(1050.48, 1036.4), controlPoint1: NSMakePoint(1057.8, 1003.72), controlPoint2: NSMakePoint(1054.08, 1020.04))
            innerGhost.curveToPoint(NSMakePoint(1031.32, 1111.04), controlPoint1: NSMakePoint(1044.96, 1061.4), controlPoint2: NSMakePoint(1040.32, 1087))
            innerGhost.curveToPoint(NSMakePoint(995.04, 1158.08), controlPoint1: NSMakePoint(1024.28, 1129.84), controlPoint2: NSMakePoint(1013.88, 1149))
            innerGhost.curveToPoint(NSMakePoint(911.84, 1174.36), controlPoint1: NSMakePoint(970.96, 1169.68), controlPoint2: NSMakePoint(938, 1169.44))
            innerGhost.curveToPoint(NSMakePoint(767.2, 1209.24), controlPoint1: NSMakePoint(863.12, 1183.48), controlPoint2: NSMakePoint(814.52, 1194.28))
            innerGhost.curveToPoint(NSMakePoint(646.96, 1269.4), controlPoint1: NSMakePoint(726.56, 1222.08), controlPoint2: NSMakePoint(677.56, 1237.72))
            innerGhost.curveToPoint(NSMakePoint(639, 1279.2), controlPoint1: NSMakePoint(644.04, 1272.4), controlPoint2: NSMakePoint(641.16, 1275.6))
            innerGhost.curveToPoint(NSMakePoint(636.88, 1282.96), controlPoint1: NSMakePoint(638.28, 1280.36), controlPoint2: NSMakePoint(637.28, 1281.64))
            innerGhost.curveToPoint(NSMakePoint(647.48, 1293.6), controlPoint1: NSMakePoint(633.56, 1293.16), controlPoint2: NSMakePoint(637.52, 1291.76))
            innerGhost.curveToPoint(NSMakePoint(785.12, 1333.4), controlPoint1: NSMakePoint(694.56, 1302.24), controlPoint2: NSMakePoint(740.72, 1315.56))
            innerGhost.curveToPoint(NSMakePoint(1007.4, 1470.48), controlPoint1: NSMakePoint(866.4, 1365.96), controlPoint2: NSMakePoint(941.2, 1413.32))
            innerGhost.curveToPoint(NSMakePoint(1244.88, 1771.88), controlPoint1: NSMakePoint(1104.52, 1554.28), controlPoint2: NSMakePoint(1184.92, 1658.6))
            innerGhost.curveToPoint(NSMakePoint(1294.28, 1896.2), controlPoint1: NSMakePoint(1265.36, 1810.6), controlPoint2: NSMakePoint(1287.36, 1852.96))
            innerGhost.curveToPoint(NSMakePoint(1132.24, 2098.96), controlPoint1: NSMakePoint(1311.68, 2004.76), controlPoint2: NSMakePoint(1222.32, 2066.2))
            innerGhost.curveToPoint(NSMakePoint(990.44, 2153.64), controlPoint1: NSMakePoint(1084.4, 2116.36), controlPoint2: NSMakePoint(1035.08, 2128.28))
            innerGhost.curveToPoint(NSMakePoint(933.6, 2217.12), controlPoint1: NSMakePoint(970.08, 2165.2), controlPoint2: NSMakePoint(930.52, 2188.28))
            innerGhost.curveToPoint(NSMakePoint(981.16, 2260.64), controlPoint1: NSMakePoint(935.92, 2239.04), controlPoint2: NSMakePoint(963.04, 2253.84))
            innerGhost.curveToPoint(NSMakePoint(1020.12, 2267.52), controlPoint1: NSMakePoint(993.44, 2265.24), controlPoint2: NSMakePoint(1006.92, 2268.24))
            innerGhost.curveToPoint(NSMakePoint(1064.08, 2252.32), controlPoint1: NSMakePoint(1036, 2266.64), controlPoint2: NSMakePoint(1049.6, 2258.24))
            innerGhost.curveToPoint(NSMakePoint(1232.64, 2224.28), controlPoint1: NSMakePoint(1116.68, 2230.76), controlPoint2: NSMakePoint(1175.52, 2215.4))
            innerGhost.curveToPoint(NSMakePoint(1311.4, 2260.6), controlPoint1: NSMakePoint(1261.2, 2228.72), controlPoint2: NSMakePoint(1290.8, 2239.56))
            innerGhost.curveToPoint(NSMakePoint(1319.32, 2273.96), controlPoint1: NSMakePoint(1316.36, 2265.68), controlPoint2: NSMakePoint(1318.2, 2267.8))
            innerGhost.curveToPoint(NSMakePoint(1317.2, 2311.84), controlPoint1: NSMakePoint(1321.36, 2285.32), controlPoint2: NSMakePoint(1317.84, 2300.48))
            innerGhost.curveToPoint(NSMakePoint(1311.56, 2402.8), controlPoint1: NSMakePoint(1315.4, 2342.16), controlPoint2: NSMakePoint(1313.44, 2372.48))
            innerGhost.curveToPoint(NSMakePoint(1306.08, 2750.76), controlPoint1: NSMakePoint(1304.4, 2518.44), controlPoint2: NSMakePoint(1297.48, 2635))
            innerGhost.curveToPoint(NSMakePoint(1330.72, 2898.24), controlPoint1: NSMakePoint(1309.76, 2800.4), controlPoint2: NSMakePoint(1316.24, 2850.48))
            innerGhost.curveToPoint(NSMakePoint(1395.08, 3032.84), controlPoint1: NSMakePoint(1345.12, 2945.68), controlPoint2: NSMakePoint(1369.24, 2990.72))
            innerGhost.curveToPoint(NSMakePoint(1578.32, 3232.56), controlPoint1: NSMakePoint(1442.72, 3110.44), controlPoint2: NSMakePoint(1504.6, 3178.96))
            innerGhost.curveToPoint(NSMakePoint(1949.36, 3368.88), controlPoint1: NSMakePoint(1686.36, 3311.16), controlPoint2: NSMakePoint(1816.8, 3356.24))
            innerGhost.curveToPoint(NSMakePoint(2076.52, 3372.84), controlPoint1: NSMakePoint(1991.56, 3372.92), controlPoint2: NSMakePoint(2034.12, 3372.84))
            innerGhost.closePath()
            return innerGhost
        }
    }
    
    func drawPoints() {
        
//        let linetoPointy = ["182.64", "394.36", "606.08", "817.8", "1029.52", "1241.24", "1452.96", "1664.68", "1876.4", "2088.16", "2299.88", "2511.6", "2723.32", "2935.04", "3146.76", "3358.48", "3570.2", "3781.92"]
//        let movelinPointx = ["248.36", "460.08", "671.8", "883.52", "1095.24", "1306.96", "1518.68", "1730.4", "1942.12", "2153.88", "2365.6", "2577.32", "2789.04", "3000.76", "3212.48", "3424.2", "3635.92", "3847.64"]
//        let movelinPointy = ["314.08", "525.8", "737.52", "949.24", "1160.96", "1372.68", "1584.4", "1796.12", "2007.84", "2219.6", "2431.32", "2643.04", "2854.76", "3066.48", "3278.2", "3489.92", "3701.64", "3913.36"]
//        let controlpoint1X = ["212.06", "423.78", "635.5", "847.22", "1058.94", "1270.66", "1482.38", "1694.1", "1905.82", "2117.58", "2329.3", "2541.02", "2752.74", "2964.46", "3176.18", "3387.9", "3599.62", "3811.34"]
//        let controlpoint2Y = ["284.66", "496.38", "708.1", "919.82", "1131.54", "1343.26", "1554.98", "1766.7", "1978.42", "2190.18", "2401.9", "2613.62", "2825.34", "3037.06", "3248.78", "3460.5", "3672.22", "3883.94"]
//        let positions : [CGFloat] = [182.64, 394.36, 606.08, 817.8, 1029.52, 1241.24, 1452.96, 1664.68, 1876.4, 2088.16, 2299.88, 2511.6, 2723.32, 2935.04, 3146.76, 3358.48, 3570.2, 3781.92]
        let centers : [CGFloat] = [248.36, 460.08, 671.8, 883.52, 1095.24, 1306.96, 1518.68, 1730.4, 1942.12, 2153.88, 2365.6, 2577.32, 2789.04, 3000.76, 3212.48, 3424.2, 3635.92, 3847.64]
        let pointSize : CGFloat = 65.72 //32.86 / 2 , 32.86 /2 (1024)
        let bezierPath = NSBezierPath()
        
        
        if (displayFullGrid) {
            for coordinate in pointCoordinates {
                var rect = NSZeroRect
                rect.size = NSMakeSize(pointSize * 2, pointSize * 2)
                rect.origin = NSMakePoint(centers[coordinate.x] - pointSize, centers[coordinate.y] - pointSize)
                let pointPath = NSBezierPath(ovalInRect: rect)
                bezierPath.appendBezierPath(pointPath)
            }
        } else {
        
            for indexX in 0...17 {
                for indexY in 0...17 {
                    var rect = NSZeroRect
                    rect.size = NSMakeSize(pointSize * 2, pointSize * 2)
                    rect.origin = NSMakePoint(centers[indexX] - pointSize, centers[indexY] - pointSize)
                    let pointPath = NSBezierPath(ovalInRect: rect)
                    bezierPath.appendBezierPath(pointPath)
                }
            }
        }
        bezierPath.miterLimit = 4
        pointColor.setFill()
        bezierPath.fill()
    }
    
    var pictureRect : NSRect {
        get {
            return NSRect(
                x: codeCenter.x - CGFloat(pictureRadius),
                y: codeCenter.y - CGFloat(pictureRadius),
                width: CGFloat(pictureRadius * 2.0),
                height: CGFloat(pictureRadius * 2.0))
        }
    }
    
    
    var picturePath: NSBezierPath {
        get {
            return innerGhostPath
        }
    }
    
    private func drawPicture() {
        CGContextSaveGState(currentContext!)
        picturePath.addClip()
        if (picture?.nsPicture != nil) {
            
            CGContextSaveGState(currentContext!)
//            CGContextScaleCTM(currentContext!, 1.0, -1.0)
//            CGContextTranslateCTM(currentContext!, 0.0, -bounds.height)
            let xOffset = CGFloat(picture!.xOffset.floatValue) / scale
            let yOffset = CGFloat(picture!.yOffset.floatValue) / scale
            switch picture!.scaling {
            case .None:
                var newPictureRect = NSZeroRect
                newPictureRect.origin = NSPoint(x: xOffset, y: yOffset).add(pictureRect.origin)
                newPictureRect.size = picture!.nsPicture!.size.scale(picture!.scaleFactor.floatValue)
                //picture!.nsPicture!.drawAtPoint(NSPoint(x: xOffset, y: yOffset), fromRect: NSZeroRect, operation: NSCompositingOperation.SourceOver, fraction: 1.0)
                
                picture?.nsPicture?.drawInRect(newPictureRect, fromRect: NSZeroRect, operation:NSCompositingOperation.SourceOver, fraction: 1.0, respectFlipped: false, hints: [:])
                break
            case .FitInSquare:
                var newPictureRect = pictureRect
                newPictureRect.origin = NSPoint(x: xOffset, y: yOffset).add(pictureRect.origin)
                //picture!.nsPicture!.drawAtPoint(NSPoint(x: xOffset, y: yOffset), fromRect: NSZeroRect, operation: NSCompositingOperation.SourceOver, fraction: 1.0)
                
                picture?.nsPicture?.drawInRect(newPictureRect, fromRect: NSZeroRect, operation:NSCompositingOperation.SourceOver, fraction: 1.0, respectFlipped: false, hints: [:])
                break
                
            }
            
            CGContextRestoreGState(currentContext!)
            
            
            
        } else {
            NSColor.grayColor().setFill()
            picturePath.fill()
        }
        CGContextRestoreGState(currentContext!)
        
    }
    
    
    func createCGImage() -> CGImage? {
        
        //method 1
        //        let image = NSImage(size: NSSize(width: bounds.width, height: bounds.height), flipped: true, drawingHandler: { rect in
        //            self.drawRect(self.bounds)
        //            return true
        //        })
        var rect = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        //        return image.CGImageForProposedRect(&rect, context: bitmapContext(), hints: nil)
        
        
        //method 2
        if let pdfRep = NSPDFImageRep(data: dataWithPDFInsideRect(bounds)) {
            return pdfRep.CGImageForProposedRect(&rect, context: bitmapContext(), hints: nil)
        }
        return nil
    }
    
    func bitmapImageData(type: NSBitmapImageFileType) -> NSData? {
        if let bitmapRep = NSBitmapImageRep(bitmapDataPlanes: nil,
                                            pixelsWide: Int(bounds.size.width),
                                            pixelsHigh: Int(bounds.size.height), bitsPerSample: 8,
                                            samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                                            colorSpaceName: NSCalibratedRGBColorSpace,
                                            bytesPerRow: Int(bounds.size.width) * 4,
                                            bitsPerPixel: 32) {
            NSGraphicsContext.saveGraphicsState()
            if let context = NSGraphicsContext(bitmapImageRep: bitmapRep) {
                NSGraphicsContext.setCurrentContext(context)
                var rect = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
                bitmapRep.CGImageForProposedRect(&rect,  context: context, hints: nil)
                displayRectIgnoringOpacity(bounds, inContext: context)
            }
            NSGraphicsContext.restoreGraphicsState()
            return bitmapRep.representationUsingType(type, properties: [:])
        }
        return nil
    }
    
    func bitmapContext() -> NSGraphicsContext? {
        var context : NSGraphicsContext? = nil
        if let imageRep =  NSBitmapImageRep(bitmapDataPlanes: nil,
                                            pixelsWide: Int(bounds.size.width),
                                            pixelsHigh: Int(bounds.size.height), bitsPerSample: 8,
                                            samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                                            colorSpaceName: NSCalibratedRGBColorSpace,
                                            bytesPerRow: Int(bounds.size.width) * 4,
                                            bitsPerPixel: 32) {
            imageRep.size = NSSize(width: bounds.size.width, height: bounds.size.height)
            context = NSGraphicsContext(bitmapImageRep: imageRep)
        }
        return context
    }
    
    func refresh() {
        needsDisplay = true
    }
    
    
    func PDFImageData(filter: QuartzFilter?) -> NSData? {
        return dataWithPDFInsideRect(bounds)
        //        let pdfData = NSMutableData()
        //
        //        var data : NSData?
        //        let consumer = CGDataConsumerCreateWithCFData(pdfData);
        //        var mediaBox =  CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        //        if let pdfContext = CGPDFContextCreate(consumer, &mediaBox, nil) {
        //            CGPDFContextBeginPage (pdfContext, nil)
        //            filter?.applyToContext(pdfContext)
        //            let pdfContextPtr: UnsafeMutablePointer<CGContext> = UnsafeMutablePointer(UnsafePointer<CGContext>(unsafeAddressOf(pdfContext)))
        //            let context = NSGraphicsContext(graphicsPort: pdfContextPtr, flipped: true);
        //            NSGraphicsContext.saveGraphicsState()
        //            NSGraphicsContext.setCurrentContext(context)
        //            pdfData.appendData(dataWithPDFInsideRect(bounds))
        //            filter?.applyToContext(pdfContext)
        //            CGPDFContextEndPage (pdfContext)
        //            CGPDFContextClose(pdfContext)
        //            NSGraphicsContext.restoreGraphicsState()
        //
        //        }
        //        return data
    }
    
    
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if (viewTrackingArea != nil) {
            removeTrackingArea(viewTrackingArea!)
        }
        let options : NSTrackingAreaOptions = [.MouseEnteredAndExited,.MouseMoved,.ActiveAlways]
        viewTrackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(viewTrackingArea!)
    }
    
    
    override func resignFirstResponder() -> Bool {
        needsDisplay = true
        return super.resignFirstResponder()
    }
    
    override var acceptsFirstResponder : Bool {
        get {
            return true
        }
    }
    override var canBecomeKeyView : Bool {
        get {
            return true
        }
    }
    
    var cursor : NSCursor = NSCursor.arrowCursor()
    
    override func resetCursorRects() {
        discardCursorRects()
        addCursorRect(pictureRect, cursor:cursor);
    }
    
    var origin : NSPoint {
        get {
            return NSPoint(
                x: ceil(bounds.size.width * 0.5 + bounds.origin.x),
                y: ceil(bounds.size.height * 0.5 + bounds.origin.y)
            );
        }
    }
    
    
    override func keyDown(theEvent: NSEvent) {
        guard picture != nil else { return }
        
        let character = Int(theEvent.keyCode)
        if (character >= kVK_LeftArrow && character <= kVK_UpArrow) {
            var prirastok : Float = 1.0
            var useXOffset = false
            var useYOffset = false
            switch (character) {
            case kVK_UpArrow:
                useYOffset = true
                break
            case kVK_DownArrow:
                prirastok *= -1.0
                useYOffset = true
                break
            case kVK_RightArrow:
                useXOffset = true;
                break
            case kVK_LeftArrow:
                prirastok *= -1.0
                useXOffset = true
                break
            default:
                break
            }
            
            if isShiftDown && isAltDown {
                prirastok *= 0.1
                picture!.scaleFactor = NSNumber(float: picture!.scaleFactor.floatValue + prirastok)
                
            } else if isAltDown {
                
                prirastok *= 0.05
                picture!.scaleFactor = NSNumber(float: picture!.scaleFactor.floatValue + prirastok)
                
            } else if isShiftDown {
                
                prirastok *= 10
                if useXOffset {
                    picture!.xOffset = NSNumber(float: picture!.xOffset.floatValue + prirastok)
                }
                
                if useYOffset {
                    picture!.yOffset = NSNumber(float: picture!.yOffset.floatValue + prirastok)
                }
            } else {
                if useXOffset {
                    picture!.xOffset = NSNumber(float: picture!.xOffset.floatValue + prirastok)
                }
                
                if useYOffset {
                    picture!.yOffset = NSNumber(float: picture!.yOffset.floatValue + prirastok)
                }
            }
            
        } else {
            super.keyDown(theEvent)
        }
    }
    
    var isShiftDown = false
    var isAltDown = false
    
    override func flagsChanged(theEvent: NSEvent) {
        
        isShiftDown = NSEvent.modifierFlags().contains(NSEventModifierFlags.Shift)
        isAltDown = NSEvent.modifierFlags().contains(NSEventModifierFlags.Option)
        super.flagsChanged(theEvent)
        needsDisplay = true
    }
    
    override func mouseDown(theEvent: NSEvent) {
        guard picture != nil else {return}
        var lastMousePoint = mousePosition
        let mouseStart = mousePosition
        var isPictureDragged = false
        let ring = NSBezierPath(ovalInRect: pictureRect)
        let originalXOffset = picture!.xOffset
        let originalYOffset = picture!.yOffset
        if (ring.containsPoint(mousePosition)) {
            isPictureDragged = true
            cursor = NSCursor.closedHandCursor()
            window?.invalidateCursorRectsForView(self)
        }
        needsDisplay = true
        
        autoreleasepool {
            let mask : NSEventMask = [.FlagsChanged , .LeftMouseUp , .LeftMouseDragged]
            var theEvent: NSEvent? = window?.nextEventMatchingMask(mask, untilDate: NSDate.distantFuture(), inMode: NSDefaultRunLoopMode, dequeue: true)
            while (theEvent != nil && theEvent!.type != .LeftMouseUp) {
                if (theEvent!.type == .FlagsChanged) {
                    flagsChanged(theEvent!)
                } else {
                    
                    if (isPictureDragged) {
                        let rychlostPosuvania : CGFloat = 1.0
                        let prirastokX = Float(round((mousePosition.x - mouseStart.x  + 0.5) * rychlostPosuvania))
                        let prirastokY = Float(round((mousePosition.y - mouseStart.y  + 0.5) * rychlostPosuvania)) //mind the flipness
                        if (theEvent!.modifierFlags.contains(NSEventModifierFlags.Shift)) {
                            
                            let zmenaPolohyX = fabs(mousePosition.x - lastMousePoint.x)
                            let zmenaPolohyY = fabs(mousePosition.y - lastMousePoint.y)
                            if (zmenaPolohyX > 10.0 || zmenaPolohyY > 10.0) {
                                if (zmenaPolohyX > 10.0) {
                                    picture!.xOffset = NSNumber(float: originalXOffset.floatValue + prirastokX)
                                }
                                if (zmenaPolohyY > 10.0) {
                                    picture!.yOffset = NSNumber(float: originalYOffset.floatValue + prirastokY)
                                }
                                lastMousePoint = mousePosition
                            }
                            
                        } else {
                            picture!.xOffset = NSNumber(float:originalXOffset.floatValue + prirastokX)
                            picture!.yOffset = NSNumber(float:originalYOffset.floatValue + prirastokY)
                        }
                        
                    }
                    
                }
                theEvent = window?.nextEventMatchingMask(mask, untilDate: NSDate.distantFuture(), inMode: NSDefaultRunLoopMode, dequeue: true)
            }
            cursor = NSCursor.openHandCursor()
            window?.invalidateCursorRectsForView(self)
            
        }
        isPictureDragged = false
        needsDisplay = true
    }
    
    override var flipped : Bool {
        get {
            return false
        }
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        
        guard picture != nil else {return}
        var isMouseOverPicture = false
        if (picturePath.containsPoint(mousePosition)) {
            isMouseOverPicture = true
        }
        if (isMouseOverPicture) {
            cursor = NSCursor.openHandCursor()
        } else {
            cursor = NSCursor.arrowCursor()
        }
        
        window?.invalidateCursorRectsForView(self)
        needsDisplay = true
    }

}
