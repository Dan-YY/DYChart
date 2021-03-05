//
//  DDLine.swift
//  DY2DBodyNodeLib
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DView: UIView {

	var dotType: DDLineChartDot.DotType = .non
	var lineType: LineType = .stright

	private var range: ClosedRange<Int> = 0...100

	private let chartView = UIView()
	private let horizontalAxisView: Chart2DAxisView? = nil
	private let verticalAxisView: Chart2DAxisView? = nil
	private let keyView: UIView? = nil
	

	enum LineType {
		case curve, stright
	}

	// MARK: INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {

	}

	// MARK: Public
	func value(array: [NSNumber]) {

	}

	func value(array: [String: NSNumber]) {

	}


}

class DDChartBackground: UIView {

}

class DDLineChartBackground: UIView {


	// make Outter

	// make scaler

	// make grids

	// make colors

	func setupView() {

	}
}


class DDLineChartDot: CAShapeLayer {
	var valueX: NSNumber = 0
	var valueY: NSNumber = 0
	var type: DotType = .non

	enum DotType {
		case non, circle, cycle
	}

	override init() {
		super.init()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {

	}

	// MARK: Animation
	func value(to: NSNumber, animation: Bool, duration: TimeInterval? = nil) {

	}

	struct config {
		var dotType: DotType = .non
		var dotSize: CGSize = CGSize(width: 5, height: 5)
		var lineWidth: CGFloat = 2
		var strokeColor: UIColor = .systemGray4
		var fillColor: UIColor = .systemGray5
	}

	override func display() {
		print("display in dot")
	}

	func makeDot(config: config) {

		strokeColor = config.strokeColor.cgColor
		fillColor = config.fillColor.cgColor
		lineWidth = config.lineWidth
		type = config.dotType

		let arcCenter: CGPoint = CGPoint(x: 0, y: 0)
		let radius: CGFloat = min(config.dotSize.width, config.dotSize.height)
		let startAngle: CGFloat = 0
		let endAngle: CGFloat = CGFloat.pi * 2

		let bezierPath = UIBezierPath(arcCenter: arcCenter,
														radius: radius,
														startAngle: startAngle,
														endAngle: endAngle,
														clockwise: true)

		path = bezierPath.cgPath
	}
}
