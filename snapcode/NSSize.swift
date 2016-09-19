import Foundation

extension NSSize {
    
    func scale(factor: Float) -> NSSize {
        return NSSize(width: self.width * CGFloat(factor), height: self.height * CGFloat(factor))
    }
    
    func scaleProportionalyToSize(targetSize: NSSize) -> NSRect
    {
        let imageSize = self
        let width  = imageSize.width
        let height = imageSize.height
        
        let targetWidth  = targetSize.width
        let targetHeight = targetSize.height
        
        var scaleFactor : CGFloat  = 0.0;
        var scaledWidth  = targetWidth
        var scaledHeight = targetHeight
        
        var thumbnailPoint = NSZeroPoint
        
        if ( NSEqualSizes( imageSize, targetSize ) == false )
        {
            
            let widthFactor  = targetWidth / width;
            let heightFactor = targetHeight / height;
            
            if widthFactor < heightFactor {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor;
            }
            scaledWidth  = width  * scaleFactor;
            scaledHeight = height * scaleFactor;
            
            if  widthFactor < heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
                
            } else if widthFactor > heightFactor {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        var thumbnailRect = NSZeroRect
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        return thumbnailRect
    }
}
