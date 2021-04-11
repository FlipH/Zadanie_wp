//
//  ProgressView.swift
//  wpZadanie
//
//  Created by Filip Harasim on 08/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    var currentPoint: Int = 0
    var divider: Int = 0
    var oldPath: UIBezierPath?
    var endPoint: Int {
        return currentPoint + (Int(self.bounds.width) / divider)
    }

    func drawCorrectAnswer() {
        guard currentPoint < Int(self.bounds.width) else {
            return
        }
        drawLineFromPointToPoint(startX: currentPoint, toEndingX: endPoint, startingY: 1, toEndingY: 1, ofColor: .green, widthOfLine: self.bounds.height, inView: self)
        currentPoint = endPoint
    }
    func drawIncorrectAnswer() {
        guard currentPoint < Int(self.bounds.width) else {
            return
        }
        drawLineFromPointToPoint(startX: currentPoint, toEndingX: endPoint, startingY: 1, toEndingY: 1, ofColor: .red, widthOfLine: self.bounds.height, inView: self)
        currentPoint = endPoint
    }


    func drawLineFromPointToPoint(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {

        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.25
        shapeLayer.add(animation, forKey: "drawLineAnimation")

        view.layer.addSublayer(shapeLayer)

    }

}
