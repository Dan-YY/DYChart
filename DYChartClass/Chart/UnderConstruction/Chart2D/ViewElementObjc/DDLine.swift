////
////  DDLine.swift
////  DYChartClass
////
////  Created by macbook on 2020-01-14.
////  Copyright © 2020 Dan's Studio. All rights reserved.
////

import UIKit

class DDLine: CAShapeLayer {

	enum LineType {
		case normal, dash, dot
	}

	enum DirectionType {
		case horizontal, vertical
	}

	struct config {
		var lineType: LineType = .normal
		var directionType: DirectionType = .horizontal
		var lineWidth: CGFloat = 10
		var linePattern: [NSNumber] = [5.0, 3.0]
		var lineColor: UIColor = .systemGray3
		var rectSize: CGSize
	}

	override func display() {
		print("aa")
	}

	func makeLine(config: config) {

		let color = config.lineColor
		let width = config.lineWidth
		let direction = config.directionType
		//let type = config.lineType
		//let pattern = config.linePattern
		let size = config.rectSize

		let startPoint: CGPoint = CGPoint(x: 0, y: 0)
		let endPoint: CGPoint

		switch direction {
		case .horizontal:
			//startPoint = CGPoint(x: 0, y: 0)
			endPoint = CGPoint(x: size.width, y: 0)
		case .vertical:
			endPoint = CGPoint(x: 0, y: size.height)
		}


		let thisPath = UIBezierPath()
		thisPath.move(to: startPoint)
		thisPath.addLine(to: endPoint)
		strokeColor = color.cgColor
		lineWidth = width
		//line.lineDashPattern = pattern
		path = thisPath.cgPath




//		switch direction {
//		case .horizontalLine:
//			lineRectSize = CGSize(width: length, height: lineSetting.lineWidth)
//			startPoint = CGPoint(x: -length / 2, y: 0)
//			endPoint = CGPoint(x: length / 2, y: 0)
//		case .verticalLine:
//			lineRectSize = CGSize(width: lineSetting.lineWidth, height: length)
//			startPoint = CGPoint(x: 0, y: -length / 2)
//			endPoint = CGPoint(x: 0, y: length / 2)
//		}
//
//		switch lineSetting.lineType {
//		case .normal:
//			let line = UIView(frame: CGRect(x: length / 2, y: length / 2,
//																			width: lineRectSize.width, height: lineRectSize.height))
//			line.backgroundColor = lineSetting.lineColor
//			addSubview(line)
//			line.center = center
//		case .dash:
//			let path = UIBezierPath()
//			path.move(to: startPoint)
//			path.addLine(to: endPoint)
//			let line = CAShapeLayer()
//			line.strokeColor = lineSetting.lineColor.cgColor
//			line.lineWidth = lineSetting.lineWidth
//			line.lineDashPattern = lineSetting.dashesPattern
//			line.path = path.cgPath
//			layer.addSublayer(line)
//		case .dot:
//			let path = UIBezierPath()
//			path.move(to: startPoint)
//			path.addLine(to: endPoint)
//			let line = CAShapeLayer()
//			line.strokeColor = lineSetting.lineColor.cgColor
//			line.lineWidth = lineSetting.lineWidth
//			line.lineDashPattern = lineSetting.dashesPattern
//			line.path = path.cgPath
//			layer.addSublayer(line)
//			fatalError("DYMeasurementViewLineType .dot not writen yet")
//		}
	}
}

//
//
//
//struct DYLineSetting {
//	//var lineType: DYMeasurementViewLineType
//	var lineWidth: CGFloat = 2
//	var lineColor: UIColor = .systemGray
//	var dashesPattern: [NSNumber] = [10.0, 3.8]
//	var isDynamic: Bool = false
//}
//
//private enum LineDirectionType {
//	case horizontalLine, verticalLine
//}
//
//class DYMeasurementView: UIView {
//	//let type: DYMeasurementViewType
//	let lineSetting: DYLineSetting
//	let isDynamic: Bool
//	let maxLength: CGFloat
//	let fixLength: CGFloat?
//
//
//	init(type: DYMeasurementViewType, lineSetting: DYLineSetting, viewSize: CGSize, fixLength: CGFloat? = nil) {
//		self.type = type
//		self.lineSetting = lineSetting
//		self.isDynamic = lineSetting.isDynamic
//		self.maxLength = max(viewSize.width, viewSize.height)
//		self.fixLength = fixLength ?? nil
//		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//		factory()
//	}
//
//	private func factory() {
//		switch type {
//		case .cross:
//			makeLine(direction: .horizontalLine)
//			makeLine(direction: .verticalLine)
//		case .horizontalLine:
//			makeLine(direction: .horizontalLine)
//		case .verticalLine:
//			makeLine(direction: .verticalLine)
//		default:
//			fatalError("DYMeasurementViewType type not writen yet")
//		}
//	}
//
//	private func makeLine(direction: LineDirectionType) {
//		let lineRectSize: CGSize
//		let startPoint: CGPoint
//		let endPoint: CGPoint
//		var length: CGFloat
//
//		switch isDynamic {
//		case false:
//			length = maxLength * 2
//		case true:
//			length = (maxLength * maxLength * 2).squareRoot()
//		}
//
//		if fixLength != nil {
//			length = fixLength!
//		}
//
//		switch direction {
//		case .horizontalLine:
//			lineRectSize = CGSize(width: length, height: lineSetting.lineWidth)
//			startPoint = CGPoint(x: -length / 2, y: 0)
//			endPoint = CGPoint(x: length / 2, y: 0)
//		case .verticalLine:
//			lineRectSize = CGSize(width: lineSetting.lineWidth, height: length)
//			startPoint = CGPoint(x: 0, y: -length / 2)
//			endPoint = CGPoint(x: 0, y: length / 2)
//		}
//
//		switch lineSetting.lineType {
//		case .normal:
//			let line = UIView(frame: CGRect(x: length / 2, y: length / 2,
//																			width: lineRectSize.width, height: lineRectSize.height))
//			line.backgroundColor = lineSetting.lineColor
//			addSubview(line)
//			line.center = center
//		case .dash:
//			let path = UIBezierPath()
//			path.move(to: startPoint)
//			path.addLine(to: endPoint)
//			let line = CAShapeLayer()
//			line.strokeColor = lineSetting.lineColor.cgColor
//			line.lineWidth = lineSetting.lineWidth
//			line.lineDashPattern = lineSetting.dashesPattern
//			line.path = path.cgPath
//			layer.addSublayer(line)
//		case .dot:
//			let path = UIBezierPath()
//			path.move(to: startPoint)
//			path.addLine(to: endPoint)
//			let line = CAShapeLayer()
//			line.strokeColor = lineSetting.lineColor.cgColor
//			line.lineWidth = lineSetting.lineWidth
//			line.lineDashPattern = lineSetting.dashesPattern
//			line.path = path.cgPath
//			layer.addSublayer(line)
//			fatalError("DYMeasurementViewLineType .dot not writen yet")
//		}
//	}
//
//	private func commonInit() {
//
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}
//
