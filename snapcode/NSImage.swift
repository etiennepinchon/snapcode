import Foundation
import AppKit

extension NSImage {
    
    func toBase64() -> String {
        guard let imageData = TIFFRepresentation else {return ""}
        return imageData.base64EncodedStringWithOptions(.Encoding76CharacterLineLength)
    }
    
    static func checkerboardImageWithSize(size : CGFloat) -> NSImage {
        let fullRect = NSRect(x: 0, y: 0, width: size, height: size)
        let halfSize : CGFloat = size * 0.5;
        let upperSquareRect = NSRect(x: 0, y: 0, width: halfSize, height: halfSize);
        let bottomSquareRect = NSRect(x: halfSize, y: halfSize, width:halfSize, height: halfSize);
        let image = NSImage(size: NSSize(width: size, height: size))
        image.lockFocus()
        NSColor.whiteColor()
        NSRectFill(fullRect)
        NSColor(deviceWhite: 0.0, alpha:0.1).set()
        NSRectFill(upperSquareRect)
        NSRectFill(bottomSquareRect)
        image.unlockFocus()
        return image
    }
    
    func thumbnailImageWithWidth(width: CGFloat) -> NSImage {
        let imageAspectRatio = size.width / size.height;
        let thumbnailSize = NSMakeSize(width, width * imageAspectRatio);
        let thumbnailImage = NSImage(size: thumbnailSize)
        
        thumbnailImage.lockFocus()
        self.drawInRect(NSRect(x: 0.0, y: 0.0, width: thumbnailSize.width, height: thumbnailSize.height),
                        fromRect:NSZeroRect,
                        operation:NSCompositingOperation.SourceOver,
                        fraction:1.0)
        thumbnailImage.unlockFocus()
        
        return thumbnailImage
    }
}
