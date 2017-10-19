//
//  PixelColor.swift
//  ZQShapedButtonDemo
//
//  Created by zhaozq on 2017/10/19.
//  Copyright © 2017年 zhao. All rights reserved.
//

import UIKit
import Foundation
import CoreImage
import CoreGraphics

extension UIImage {
    func getPixelColor(at point: CGPoint) -> UIColor? {
        
        guard let components = self.getPixelColorComponents(at: point) else {
            return nil
        }
        
        print(components)
        
        //let r = CGFloat(components.0) / CGFloat(255.0)
        return UIColor(red: CGFloat(components.0 / 255), green: CGFloat(components.1 / 255), blue: CGFloat(components.2 / 255), alpha: CGFloat(components.3 / 255))
    }
    
    func getPixelColorComponents(at point: CGPoint) -> (UInt8, UInt8, UInt8, UInt8)? {
        
        guard let imageRef = self.cgImage else {
            return nil
        }
        let width = imageRef.width //Int(self.size.width)
        let height = imageRef.height  //Int(self.size.height)
        
        let wScale = width / Int(self.size.width)
        let hScale = height / Int(self.size.height)
        let x = Int(point.x) * wScale
        let y = Int(point.y) * hScale
        
        guard x < width && y < height else {
            return nil
        }
        
        guard let pixelData:CFData = self.cgImage?.dataProvider?.data, let pointer = CFDataGetBytePtr(pixelData) else {
            return nil
        }
        
        let bytesPerPixel = 4
        let offset = (x + y * width) * bytesPerPixel
        
        print("alpha: \(pointer[offset + 3])")
        
        return (pointer[offset], pointer[offset + 1], pointer[offset + 2], pointer[offset + 3])
    }
}
///Point Conversion
extension UIImageView {
    func viewToImageTransform() -> CGAffineTransform {
        let contentMode = self.contentMode
        
        guard let img = self.image, self.frame.size.width != 0 && self.frame.size.height != 0 && (contentMode == .scaleToFill || contentMode == .scaleAspectFill || contentMode == .scaleAspectFit)else {
            return .identity
        }
        
        // the width and height ratios
        let rWidth = img.size.width / self.frame.size.width;
        let rHeight = img.size.height / self.frame.size.height;
        
        // whether the image will be scaled according to width
        let imageWiderThanView = rWidth > rHeight;
        
        if (contentMode == .scaleAspectFit || contentMode == .scaleAspectFill) {
            // The ratio to scale both the x and y axis by
            let ratio = ((imageWiderThanView && contentMode == .scaleAspectFit) || (!imageWiderThanView && contentMode == .scaleAspectFill)) ? rWidth:rHeight;
            // The x-offset of the inner rect as it gets centered
            let xOffset = (img.size.width - (self.frame.size.width*ratio)) * 0.5;
            // The y-offset of the inner rect as it gets centered
            let yOffset = (img.size.height - (self.frame.size.height*ratio)) * 0.5;
            return CGAffineTransform(scaleX: ratio, y: ratio).concatenating(CGAffineTransform(translationX: xOffset, y: yOffset));
            
        } else {
            return CGAffineTransform(scaleX: rWidth, y: rHeight)
        }
    }
    
    func imageToViewTransform() -> CGAffineTransform {
        return self.viewToImageTransform().inverted()
    }
    
    func pointTransformToImage(at point: CGPoint) -> CGPoint {
        return __CGPointApplyAffineTransform(point, self.viewToImageTransform())
    }
}
