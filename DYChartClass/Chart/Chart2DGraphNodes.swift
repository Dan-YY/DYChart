//
//  Chart2DGraphNodes.swift
//  DYChartClass
//
//  Created by macbook on 2020-01-20.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class Chart2DGraphNodes: UIView {

	//displayLinkvar Start
	var lineShape = CAShapeLayer()
	var displayLink: CADisplayLink?
	private var prevAnimationTimeStampe: Double = 0
	private var prevAnimationDuration: Double = 0
	var preferredDelegateUpdatesPerSecond = 60

	//displayLink var end
	var linesArray = [Chart2DLine]()
	private var dotPositionArray = [CGPoint]()

	var nodesLayerArray = [CALayer]()
	var dotsArray = [Chart2DDot]()

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func insertData(data: [Double], xPosition: [CGFloat], yHeight: CGFloat, config: Chart2DDataConfig) {
		//let nodesLayer = CALayer()
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
			dotPositionArray.append(origin)
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
			layer.addSublayer(shape)
			dotsArray.append(shape)
		}

		//setupLine(data: data, xPosition: xPosition, yHeight: yHeight, config: config)
		setupLineGradient(data: data, xPosition: xPosition, yHeight: yHeight, config: config)
		// test
		let patha = UIBezierPath()
		patha.move(to: CGPoint(x: 20, y: 50))
		patha.addLine(to: CGPoint(x: 100, y: 200))
		lineShape.path = patha.cgPath
		lineShape.lineWidth = 3
		lineShape.strokeColor = UIColor.black.cgColor
		layer.addSublayer(lineShape)
	}

	private func setupLine(data: [Double], xPosition: [CGFloat], yHeight: CGFloat, config: Chart2DDataConfig) {
		let linConfig = ChartStraightLine.config(lineType: .normal, lineWidth: 1, linePattern: nil, lineColor: .systemTeal)
		let yBasePosition = yHeight

		for i in 0..<dotPositionArray.count - 1 {
			let yValuePositionA = CGFloat(data[i] / 100) * yBasePosition
			let yValuePositionB = CGFloat(data[i + 1] / 100) * yBasePosition
			let xPositionA = xPosition[i]
			let xPositionB = xPosition[i + 1]
			let originA: CGPoint
			let originB: CGPoint
			let line: Chart2DLine
			switch config.animation {
			case .before:
				originA = CGPoint(x: xPositionA, y: yBasePosition)
				originB = CGPoint(x: xPositionB, y: yBasePosition)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
				line.positionA = CGPoint(x: xPositionA, y: yBasePosition - yValuePositionA)
				line.positionB = CGPoint(x: xPositionB, y: yBasePosition - yValuePositionB)
			case .after:
				originA = CGPoint(x: xPositionA, y: yBasePosition - yValuePositionA)
				originB = CGPoint(x: xPositionB, y: yBasePosition - yValuePositionB)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
			case .autoPlay:
				originA = CGPoint(x: xPositionA, y: yBasePosition)
				originB = CGPoint(x: xPositionB, y: yBasePosition)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
			}
			layer.addSublayer(line)
			linesArray.append(line)
		}

		// test
		let patha = UIBezierPath()
		patha.move(to: CGPoint(x: 20, y: 50))
		patha.addLine(to: CGPoint(x: 100, y: 200))
		lineShape.path = patha.cgPath
		lineShape.lineWidth = 3
		lineShape.strokeColor = UIColor.black.cgColor
		layer.addSublayer(lineShape)
	}


	private func setupLineGradient(data: [Double], xPosition: [CGFloat], yHeight: CGFloat, config: Chart2DDataConfig) {
		let linConfig = ChartStraightLine.config(lineType: .normal, lineWidth: 1, linePattern: nil, lineColor: .systemTeal)
		let yBasePosition = yHeight

		let botLeftPoint = CGPoint(x: xPosition[0], y: yHeight)
		let botRightPoint = CGPoint(x: xPosition.last!, y: yHeight)

		let path = UIBezierPath()
		path.move(to: CGPoint(x: xPosition[0], y: yHeight - 100))
		path.addLine(to: CGPoint(x: xPosition.last!, y: yHeight - 100))
		path.addLine(to: botRightPoint)
		path.addLine(to: botLeftPoint)
		path.close()

		let newPath = UIBezierPath()
		let yValuePosition = CGFloat(data[0] / 100) * yBasePosition
		newPath.move(to: CGPoint(x: xPosition[0], y: yBasePosition - yValuePosition))
		for i in 1..<dotPositionArray.count {
			let yValuePosition = CGFloat(data[i] / 100) * yBasePosition
			newPath.addLine(to: CGPoint(x: xPosition[i], y: yBasePosition - yValuePosition))
		}
		newPath.addLine(to: botRightPoint)
		newPath.addLine(to: botLeftPoint)
		newPath.close()

		let aLine = CAShapeLayer()
		aLine.strokeColor = UIColor.black.cgColor
		aLine.path = newPath.cgPath
		aLine.lineWidth = 1
		aLine.fillColor = UIColor.clear.cgColor
		layer.addSublayer(aLine)

		let colorTop = UIColor.systemGreen.cgColor
		let colorBot = UIColor.systemOrange.cgColor
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.colors = [colorTop, colorBot]
		gradientLayer.locations = [0.0, 1.0]




		//
//		let graphPath = UIBezierPath()
//    //go to start of line
//    graphPath.move(to: CGPoint(x:columnXPoint(0), y:columnYPoint(graphPoints[0])))
//
//    //add points for each item in the graphPoints array
//    //at the correct (x, y) for the point
//    for i in 1..<graphPoints.count {
//      let nextPoint = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
//      graphPath.addLine(to: nextPoint)
//    }
//
//    //Create the clipping path for the graph gradient
//
//    //1 - save the state of the context (commented out for now)
//    context.saveGState()
//
//    //2 - make a copy of the path
//    let clippingPath = graphPath.copy() as! UIBezierPath
//
//    //3 - add lines to the copied path to complete the clip area
//    clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y:height))
//    clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
//    clippingPath.close()
//
//    //4 - add the clipping path to the context
//    clippingPath.addClip()
//
//    let highestYPoint = columnYPoint(maxValue)
//    startPoint = CGPoint(x:margin, y: highestYPoint)
//    endPoint = CGPoint(x:margin, y:self.bounds.height)
//
//    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
//    context.restoreGState()
//
//    //draw the line on top of the clipped gradient
//    graphPath.lineWidth = 2.0
//    graphPath.stroke()
		//




		for i in 0..<dotPositionArray.count - 1 {
			let yValuePositionA = CGFloat(data[i] / 100) * yBasePosition
			let yValuePositionB = CGFloat(data[i + 1] / 100) * yBasePosition
			let xPositionA = xPosition[i]
			let xPositionB = xPosition[i + 1]
			let originA: CGPoint
			let originB: CGPoint
			let line: Chart2DLine
			switch config.animation {
			case .before:
				originA = CGPoint(x: xPositionA, y: yBasePosition)
				originB = CGPoint(x: xPositionB, y: yBasePosition)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
				line.positionA = CGPoint(x: xPositionA, y: yBasePosition - yValuePositionA)
				line.positionB = CGPoint(x: xPositionB, y: yBasePosition - yValuePositionB)
			case .after:
				originA = CGPoint(x: xPositionA, y: yBasePosition - yValuePositionA)
				originB = CGPoint(x: xPositionB, y: yBasePosition - yValuePositionB)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
			case .autoPlay:
				originA = CGPoint(x: xPositionA, y: yBasePosition)
				originB = CGPoint(x: xPositionB, y: yBasePosition)
				line = Chart2DLine(start: originA, end: originB, config: linConfig)
			}
			layer.addSublayer(line)
			linesArray.append(line)
		}

		// test
		let patha = UIBezierPath()
		patha.move(to: CGPoint(x: 20, y: 50))
		patha.addLine(to: CGPoint(x: 100, y: 200))
		lineShape.path = patha.cgPath
		lineShape.lineWidth = 3
		lineShape.strokeColor = UIColor.black.cgColor
		layer.addSublayer(lineShape)
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

		let patha = UIBezierPath()
		patha.move(to: CGPoint(x: 50, y: 200))
		patha.addLine(to: CGPoint(x: 150, y: 200))
		lineShape.path = patha.cgPath
		lineShape.lineWidth = 3
		lineShape.strokeColor = UIColor.red.cgColor
		//layer.addSublayer(lineShape)

		let ani = CABasicAnimation(keyPath: "path")
		ani.duration = 2
		ani.toValue = patha
		lineShape.add(ani, forKey: "pt")
		prevAnimationDuration = duration
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
			let lineAni = CABasicAnimation(keyPath: "path")
			lineAni.isRemovedOnCompletion = false
			lineAni.fillMode = .forwards
			lineAni.duration = duration
			for line in linesArray {
				let newPath = UIBezierPath()
				newPath.move(to: line.positionA!)
				newPath.addLine(to: line.positionB!)
				lineAni.toValue = newPath
				line.path = newPath.cgPath
				line.add(lineAni, forKey: "pp")
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
		startDisplayLink()
	}

}


extension Chart2DGraphNodes {
	override func draw(_ rect: CGRect) {
		let config = ChartStraightLine.config(lineType: .normal, lineWidth: 1, linePattern: nil, lineColor: .systemTeal)
		for (i, dot) in dotsArray.enumerated() {
			if i == dotsArray.count - 2 {
				break
			}
			let line = ChartStraightLine(start: dot.position, end: dotsArray[i + 1].position, config: config)
			layer.addSublayer(line)
		}
	}
}

extension Chart2DGraphNodes {
	// MARK: DisplayLink
	private func startDisplayLink() {
		//guard delegate != nil else { return }
		stopDisplayLink()
		prevAnimationTimeStampe = CACurrentMediaTime()
//		let dLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler))
//		dLink.preferredFramesPerSecond = preferredDelegateUpdatesPerSecond
//		dLink.add(to: .main, forMode: .common)
//		displayLink = dLink
		displayLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler))
		displayLink?.preferredFramesPerSecond = preferredDelegateUpdatesPerSecond
		displayLink?.add(to: .main, forMode: .common)

	}

	private func stopDisplayLink() {
		displayLink?.invalidate()
		displayLink = nil
		//delegate?.circleValueDidUpdate(percentage: currentValue)
	}

	@objc private func displayLinkHandler() {
//		guard let progress = circleMask.presentation()?.strokeEnd else {
//			return
//		}
//		delegate?.circleValueDidUpdate(percentage: progress)
		var slapsed = CACurrentMediaTime() - prevAnimationTimeStampe
		if slapsed > prevAnimationDuration {
			stopDisplayLink()
			slapsed = prevAnimationDuration
		}
	}
}
