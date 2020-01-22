//
//  Chart2DGraphNodes.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-20.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DGraphNodes: UIView {

	var nodesLayerArray = [CALayer]()
	var dotsArray = [Chart2DDot]()

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func insertData(data: [Double], xPosition: [CGFloat], yHeight: CGFloat, config: Chart2DDataConfig) {
		let nodesLayer = CALayer()
		print(data.count, xPosition.count)
		let size = config.size
		for i in 0..<xPosition.count {
			let yBasePosition = yHeight
			let yValuePosition = CGFloat(data[i] / 100) * yBasePosition
			let xPosition = xPosition[i]
			let origin: CGPoint
//			switch config.animation {
//			case .before:
//				origin = CGPoint(x: xPosition - size.width / 2, y: yBasePosition - size.height / 2)
//			case .after:
//				origin = CGPoint(x: xPosition - size.width / 2,
//												 y: yBasePosition - size.height / 2 - yValuePosition)
//			case .autoPlay:
//				origin = CGPoint(x: xPosition - size.width / 2, y: yBasePosition - size.height / 2)
//			}
			switch config.animation {
			case .before:
				origin = CGPoint(x: xPosition - size.width / 2, y: yBasePosition)
			case .after:
				origin = CGPoint(x: xPosition - size.width / 2,
												 y: yBasePosition - yValuePosition)
			case .autoPlay:
				origin = CGPoint(x: xPosition - size.width / 2, y: yBasePosition)
			}
			let rect = CGRect(origin: origin, size: size)
			let path: UIBezierPath
			let shape = Chart2DDot()
			shape.endPosition = rect.origin
			shape.startPosition = CGPoint(x: rect.origin.x, y: yBasePosition)
			shape.yOffset = yValuePosition
			switch config.shapeType {
			case .circle:
				path = UIBezierPath(ovalIn: rect)
				shape.strokeColor = config.strokeColor.cgColor
			case .dot:
				path = UIBezierPath(ovalIn: rect)
				shape.strokeColor = config.strokeColor.cgColor
				shape.fillColor = config.fillColor.cgColor
			case .square:
				path = UIBezierPath(rect: rect)
				shape.strokeColor = config.strokeColor.cgColor
				shape.fillColor = config.fillColor.cgColor
			}
			shape.path = path.cgPath
			nodesLayer.addSublayer(shape)
			dotsArray.append(shape)
		}

		var config = ChartStraightLine.config(lineType: .normal, lineWidth: 1, linePattern: nil, lineColor: .systemTeal)
		for (i, dot) in dotsArray.enumerated() {
			if i == dotsArray.count - 2 {
				break
			}
			let line = ChartStraightLine(start: dot.position, end: dotsArray[i + 1].position, config: config)

			let path = UIBezierPath()
			//path.addLine(to: <#T##CGPoint#>)
			layer.addSublayer(line)
		}
		layer.addSublayer(nodesLayer)
	}

	func getReadyForAnimation() {
		for dot in dotsArray {
			dot.frame.origin = CGPoint(x: dot.frame.origin.x, y: dot.frame.origin.y + dot.yOffset!)
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.toValue = dot.yOffset
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			animation.duration = 2
			dot.add(animation, forKey: String("dotY"))
		}
	}

	func runAnimation(type: Chart2DAnimation.AnimationType, duration: TimeInterval) {

		switch type {
		case .sameRate:
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			animation.duration = duration
			for dot in dotsArray {
				animation.toValue = -dot.yOffset!
				dot.add(animation, forKey: String("dotY"))
			}
		case .sameSpeed:
			var maxOffset: CGFloat = 0
			for dot in dotsArray {
				maxOffset = max(maxOffset, abs(dot.yOffset!))
			}
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			for dot in dotsArray {
				animation.toValue = -dot.yOffset!
				animation.duration = Double(abs(dot.yOffset!) / maxOffset) * duration
				dot.add(animation, forKey: String("dotY"))
			}
		case .oneByOne:
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			animation.duration = duration
			for (i, dot) in dotsArray.enumerated() {
				animation.toValue = -dot.yOffset!
				animation.beginTime = CACurrentMediaTime() + duration * Double(i)
				dot.add(animation, forKey: String("dotY"))
			}
		case .oneByOneHalfDelay:
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			animation.duration = duration
			for (i, dot) in dotsArray.enumerated() {
				animation.toValue = -dot.yOffset!
				animation.beginTime = CACurrentMediaTime() + duration * Double(i) * 0.5
				dot.add(animation, forKey: String("dotY"))
			}
		case .random:
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			for (dot) in dotsArray {
				animation.toValue = -dot.yOffset!
				let random100 = Int.random(in: 0...100)
				let randomPercent = Double(random100) / 100
				animation.duration = duration * randomPercent
				dot.add(animation, forKey: String("dotY"))
			}
		}
	}

}


extension Chart2DGraphNodes {
	override func draw(_ rect: CGRect) {
		print("draw")
		var config = ChartStraightLine.config(lineType: .normal, lineWidth: 1, linePattern: nil, lineColor: .systemTeal)
		for (i, dot) in dotsArray.enumerated() {
			if i == dotsArray.count - 2 {
				break
			}
			let line = ChartStraightLine(start: dot.position, end: dotsArray[i + 1].position, config: config)
			layer.addSublayer(line)
		}
	}
}
