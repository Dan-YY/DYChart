//
//  ChartLine.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-16.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class ChartStraightLine: CAShapeLayer {
	enum LineType {
		case normal, dash, dot
	}

//	enum DirectionType {
//		case horizontal, vertical
//	}

	struct config {
		var lineType: LineType = .normal
		//var directionType: DirectionType = .horizontal
		var lineWidth: CGFloat = 10
		var linePattern: [NSNumber]? // = [5.0, 3.0]
		var lineColor: UIColor = .systemGray3
		//var rectSize: CGSize? = CGSize.zero
	}

	override func display() {
		print("aa")
	}

	convenience init(start: CGPoint, end: CGPoint, config: config) {
		self.init()
		makeLine(start: start, end: end, config: config)
	}

	func makeLine(start: CGPoint, end: CGPoint, config: config) {
		let bezierPath = UIBezierPath()
		bezierPath.move(to: start)
		bezierPath.addLine(to: end)

		strokeColor = config.lineColor.cgColor
		lineWidth = config.lineWidth
		if let pattern = config.linePattern {
			lineDashPattern = pattern
		}
		path = bezierPath.cgPath
	}

//	func makeLine(config: config) {
//
//		let color = config.lineColor
//		let width = config.lineWidth
//		let direction = config.directionType
//		let type = config.lineType
//		let pattern = config.linePattern
//		let size = config.rectSize
//
//		let startPoint: CGPoint = CGPoint(x: 0, y: 0)
//		let endPoint: CGPoint
//
//		switch direction {
//		case .horizontal:
//			//startPoint = CGPoint(x: 0, y: 0)
//			endPoint = CGPoint(x: size.width, y: 0)
//		case .vertical:
//			endPoint = CGPoint(x: 0, y: size.height)
//		}
//
//
//		let thisPath = UIBezierPath()
//		thisPath.move(to: startPoint)
//		thisPath.addLine(to: endPoint)
//		strokeColor = color.cgColor
//		lineWidth = width
//		//line.lineDashPattern = pattern
//		path = thisPath.cgPath
//
//	}
}
