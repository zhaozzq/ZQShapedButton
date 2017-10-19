//
//  ViewController.swift
//  ZQShapedButtonDemo
//
//  Created by zhaozq on 2017/10/18.
//  Copyright © 2017年 zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: ZQShapedButton!
    
    @IBOutlet weak var imgButton: ZQShapedButton!
    
    
    @IBOutlet weak var button1: ZQShapedButton!
    @IBOutlet weak var button2: ZQShapedButton!
    @IBOutlet weak var button3: ZQShapedButton!
    @IBOutlet weak var button4: ZQShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        //let path = UIBezierPath.init(arcCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 0))
        path.addArc(withCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.close()
        
        button.shapePath = path
        button.hitTestType = .path
        button.titleEdgeInsets = UIEdgeInsets.init(top: -10, left: -10, bottom: 10, right: 10)
        
        
        //        let image = UIImage.init(named: "button-normal")
        //        if let com = image?.getPixelColorComponents(at: CGPoint(x: (image?.size.width)! / CGFloat(2.0), y: (image?.size.height)! / CGFloat(2.0))) {
        //            print(com)
        //        }
        
        
        imgButton.hitTestType = .transparent
        
        button1.hitTestType = .transparent
        button2.hitTestType = .transparent
        button3.hitTestType = .transparent
        button4.hitTestType = .transparent

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

