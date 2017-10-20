//
//  ZQShapedButton.swift
//  ZQShapedButtonDemo
//
//  Created by zhaozq on 2017/10/18.
//  Copyright © 2017年 zhao. All rights reserved.
//

import UIKit

public enum ZQHitTestType {
    case none
    case path
    case transparent
}

public class ZQShapedButton: UIButton {
    
    public var hitTestType : ZQHitTestType = .none
    
    private var hitTestCache : (CGPoint, Bool)?
    
    public var shapePath : UIBezierPath? {
        didSet {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = shapePath?.cgPath
            layer.mask = shapeLayer
        }
    }
    
    convenience init(path: UIBezierPath, hitTestType type: ZQHitTestType = .none) {
        self.init(frame: .zero)
        self.shapePath = path
        self.hitTestType = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        guard self.hitTestType != .none else {
            return super.point(inside: point, with: event)
        }
        
        if  self.hitTestType == .path, let path = shapePath {
            return super.point(inside: point, with: event) && path.contains(point)
        }
        else
        {
            if let imgView = self.imageView {
                if let previous = self.hitTestCache, previous.0 == point {
                    return previous.1
                }
                
                let inside = super.point(inside: point, with: event) && !(self.isTransparent(at: point, imgView: imgView))
                self.hitTestCache = (point, inside)
                return inside
            }
            return super.point(inside: point, with: event)
        }
    }
    
    func isTransparent(at point: CGPoint, imgView: UIImageView) -> Bool {
        
        guard imgView.frame.contains(point) else {
            return true  // 超出 按透明算
        }
        
        let pt = self.convert(point, to: imgView)
        let pixel = imgView.pointTransformToImage(at: pt)
        
        if let components = imgView.image?.getPixelColorComponents(at: pixel), components.3 < 1 {
            return true
        }
        return false
    }
}
