//
//  DYScoreRound.swift
//  DY2DBodyNodeLib
//
//  Created by macbook on 2020-01-10.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class DYScoreCircle: UIView, CAAnimationDelegate {

	var lastLabelSize: CGSize = CGSize.zero

	private let maskedLayer = CALayer()
	private let circleMask = CAShapeLayer()
	private let label = UILabel()

	// MARK: Circle setting
	var circleColors: [UIColor] = [.systemRed, .systemOrange, .systemGreen] { didSet { setNeedsLayout() } }
	var circleLineWidth: CGFloat = 3 { didSet { setNeedsLayout() } }
	var colorType: ColorType = .gradient { didSet { setNeedsLayout() } }
	var startPosition: KeyPosition = .left { didSet { setNeedsLayout() } }
	var circleType: CircleType = .circle { didSet { setNeedsLayout() } }

	private let circlePercentageRange: ClosedRange<Int> = 0...100
//	var circlePercent = 100 { // range 0...100
//		didSet {
//			setNeedsLayout()
//		}
//	}

	// MARK: Label setting
	var labelIsHidden = false
	var scoreRange: ClosedRange<Int> = 0...100 { didSet { setNeedsLayout() } }
	private var currentScore: Int = 50 //{ didSet { setNeedsLayout() } }
	var scoreFont = UIFont.systemFont(ofSize: 50, weight: .medium) { didSet { setupLabel() } }

	// score prefix and suffix setting
	var prefixText: String? = nil { didSet { setupLabel()
		print("1")} }
	var prefixFont = UIFont.systemFont(ofSize: 20, weight: .medium) { didSet { setupLabel()
		 print("1")
		} }
	var suffixText: String? = nil { didSet { setupLabel()
		 print("1")
		} }
	var suffixFont = UIFont.systemFont(ofSize: 20, weight: .medium) { didSet { setupLabel()
		 print("1")
		} }

	private var displayLink: CADisplayLink?
	// static param
	private let keyPositionToCGPointArray: [CGPoint] = [CGPoint(x: 1, y: 0.5), CGPoint(x: 0.5, y: 1), CGPoint(x: 0, y: 0.5), CGPoint(x: 0.5, y: 0)]
	private let keyPositionToCenterArray: [CGPoint] = [CGPoint(x: 0.5, y: 0), CGPoint(x: 1, y: 0.5), CGPoint(x: 0.5, y: 1), CGPoint(x: 0, y: 0.5)]
	private let keyPositionToRadianArray: [CGFloat] = [0, CGFloat.pi / 2, CGFloat.pi, CGFloat.pi * 1.5 , CGFloat.pi * 2]


	// MARK: Class enum
	enum ColorType {
		case gradient, block
	}

	enum KeyPosition: Int {
		case right = 0, bottom, left, top
		func opposite() -> KeyPosition {
			let val = (rawValue + 2) % 4
			return KeyPosition(rawValue: val)!
		}
	}

	enum CircleType {
		case circle, semiCircle
		func radian() -> CGFloat {
			switch self {
			case .circle:
				return CGFloat.pi * 2
			case .semiCircle:
				return CGFloat.pi
			}
		}
	}

	// MARK: Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
		//fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {
		layer.addSublayer(maskedLayer)
		addSubview(label)
		backgroundColor = .blue
	}

	// MARK: setup
	override func layoutSubviews() {
		print("in layout subveiw")
		super.layoutSubviews()
		maskedLayer.frame.size = frame.size
		setupGradient()
		setupCircleMask()
		setupLabel()
		updateLabel()
	}

	private func setupGradient() {
		maskedLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
		switch colorType {
		case .gradient:
			let gradient = CAGradientLayer()
			switch circleType {
			case .circle:
				gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
				gradient.endPoint = keyPositionToCGPointArray[startPosition.rawValue]
				gradient.type = .conic
			case .semiCircle:
				gradient.startPoint = keyPositionToCGPointArray[startPosition.rawValue]
				let oppositeSide = startPosition.opposite()
				gradient.endPoint = keyPositionToCGPointArray[oppositeSide.rawValue]
				gradient.type = .axial
			}
			gradient.colors = circleColors.map({ $0.cgColor })
			gradient.frame.size = frame.size
			maskedLayer.addSublayer(gradient)
		case .block:
			let radianTotal = circleType.radian()
			let blockCount = circleColors.count
			var currentRadian = keyPositionToRadianArray[startPosition.rawValue]
			let radianPerBlock = radianTotal / CGFloat(blockCount)
			for color in circleColors {
				let end = currentRadian + radianPerBlock
				let path = makePath(startAngle: currentRadian, endAngle: currentRadian + radianPerBlock)
				currentRadian = end
				let arcBlock = CAShapeLayer()
				arcBlock.fillColor = UIColor.clear.cgColor
				arcBlock.strokeColor = color.cgColor
				arcBlock.path = path.cgPath
				arcBlock.lineWidth = circleLineWidth
				maskedLayer.addSublayer(arcBlock)
			}
		}
	}

	private func setupCircleMask() {
		print("setupCircleMask")
		let startAngle = keyPositionToRadianArray[startPosition.rawValue]
		let endAngle = startAngle + circleType.radian()
		//CATransaction.setDisableActions(true)
		let path = makePath(startAngle: startAngle, endAngle: endAngle)
		circleMask.fillColor = UIColor.clear.cgColor
		circleMask.strokeColor = UIColor.white.cgColor
		circleMask.path = path.cgPath
		circleMask.lineWidth = circleLineWidth
		maskedLayer.mask = circleMask
		//layer.addSublayer(circleMask)
		//CATransaction.setDisableActions(false)
		//circleMask.strokeEnd = scoreToArcPercentage(score: currentScore)
		//print("Adfsssdssf")
	}

	private func setupLabel() {
		guard !labelIsHidden else {
			return
		}
		//updateLabel(score: currentScore)
		lastLabelSize = label.sizeThatFits(label.frame.size)
		label.sizeToFit()
		label.frame.size = CGSize(width: frame.width, height: label.frame.height)
		label.frame.origin = labelOrigin()
		label.backgroundColor = .brown
		print("hehe")
	}

	private func updateLabel(score: Int? = nil) {
		guard !labelIsHidden else {
			return
		}
		let score = score ?? currentScore
		let attributedString = NSMutableAttributedString()
		if let prefixText = prefixText {
			let attribut = [NSAttributedString.Key.font: prefixFont]
			let subString = NSMutableAttributedString(string: prefixText, attributes: attribut)
			attributedString.append(subString)
		}
		let scoreAttribut = [NSAttributedString.Key.font: scoreFont]
		let scoreString = NSMutableAttributedString(string: String(score), attributes: scoreAttribut)
		attributedString.append(scoreString)
		if let suffixText = suffixText {
			let attribut = [NSAttributedString.Key.font: suffixFont]
			let subString = NSMutableAttributedString(string: suffixText, attributes: attribut)
			attributedString.append(subString)
		}
		label.attributedText = attributedString
		if lastLabelSize != label.frame.size {
			//print("notSmae", label.frame, label.bounds, label.sizeThatFits(label.frame.size))
			lastLabelSize = label.sizeThatFits(label.frame.size)
			//label.frame.height = lastLabelSize.height
			label.frame.origin = labelOrigin()
		}
		//label.backgroundColor = .brown
		print(score)
//		//print(label.frame, label.bounds, label.sizeThatFits(label.frame.size))
//		label.sizeToFit()
//		label.frame.origin = labelOrigin()
	}

	// MARK: Helper
	private func makePath(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
		let arcCenter: CGPoint
		let radius: CGFloat
		switch circleType {
		case .circle:
			arcCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
			radius = (min(frame.size.width, frame.size.height) - circleLineWidth) / 2
		case .semiCircle:
			let anchor = keyPositionToCenterArray[startPosition.rawValue]
			arcCenter = CGPoint(x: frame.width * anchor.x, y: frame.height * anchor.y)
			switch startPosition {
			case .right, .left:
				radius = min(frame.size.width / 2, frame.size.height) - circleLineWidth
			case .bottom, .top:
				radius = min(frame.size.width, frame.size.height / 2) - circleLineWidth
			}
		}
		let path = UIBezierPath(arcCenter: arcCenter,
														radius: radius,
														startAngle: startAngle,
														endAngle: endAngle,
														clockwise: true)
		return path
	}

	private func labelOrigin() -> CGPoint {
		let position: CGPoint
		switch circleType {
		case .circle:
			position = CGPoint(x: (frame.width - label.frame.width) / 2,
												 y: (frame.height - label.frame.width / 2))
		case .semiCircle:
			switch startPosition {
			case .right:
				position = CGPoint(x: (frame.width - label.frame.width) / 2, y: 0)
			case .bottom:
				position = CGPoint(x: frame.width - label.frame.width,
													 y: (frame.height - label.frame.height) / 2)
			case .left:
				position = CGPoint(x: (frame.width - label.frame.width) / 2,
													 y: frame.height - label.frame.height)
			case .top:
				position = CGPoint(x: 0, y: (frame.height - label.frame.height) / 2)
			}
		}
		return position
	}

	private func scoreToArcPercentage(score: Int) -> CGFloat {
		let total = scoreRange.upperBound - scoreRange.lowerBound
		let percentage = CGFloat(score - scoreRange.lowerBound) / CGFloat(total)
		return percentage
	}

	private func arcPercentageToScore(percentage: CGFloat) -> Int {
		let total = scoreRange.upperBound - scoreRange.lowerBound
		let value = percentage * CGFloat(total) + CGFloat(scoreRange.lowerBound)
		return Int(round(value))
	}

	// MARK: Global func
	func runAnimation(to value: Int, duration: TimeInterval) {
		print("in animating func")
		//CATransaction.begin()
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		//animation.fromValue = scoreToArcPercentage(score: currentScore)
		animation.fromValue = 0
		//currentScore = value
		animation.toValue = scoreToArcPercentage(score: value)
		animation.duration = 3
		animation.delegate = self
		//circleMask.strokeEnd = 1
		animation.isRemovedOnCompletion = false
		animation.fillMode = .forwards
		layer.add(animation, forKey: nil)

		//startDisplayLink()
		//circleMask.strokeEnd = scoreToArcPercentage(score: value)
		//CATransaction.commit()
	}

	func setScore(to value: Int, animated: Bool, duration: TimeInterval? = nil) {

		if animated {
			//runAnimation(to: value, duration: duration ?? 0.5)
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			//animation.fromValue = scoreToArcPercentage(score: currentScore)
			animation.fromValue = scoreToArcPercentage(score: currentScore)
			//currentScore = value
			animation.toValue = scoreToArcPercentage(score: value)
			//print("from", animation.fromValue, "to", animation.toValue)
			animation.duration = 1
			animation.delegate = self
			//circleMask.strokeEnd = 1
			animation.isRemovedOnCompletion = false
			animation.fillMode = .both
			circleMask.add(animation, forKey: "ama")
			//circleMask.strokeEnd = scoreToArcPercentage(score: value)

			currentScore = value

			//startDisplayLink()

		} else {
			currentScore = value
			setupLabel()
			//circleMask.speed = 0.5
			//circleMask.add(animation, forKey: "line")
		}
	}

	// MARK: Animation
	private func startDisplayLink() {
		if displayLink != nil {
			stopDisplayLink()
		}
		displayLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler))
		displayLink?.preferredFramesPerSecond = 24
		displayLink?.add(to: .main, forMode: .common)
	}

	private func stopDisplayLink() {
		displayLink?.invalidate()
		displayLink = nil
	}

	@objc private func displayLinkHandler() {
		guard let presentation = circleMask.presentation() else {
			return
		}
		let percentage = presentation.strokeEnd

		let value = arcPercentageToScore(percentage: percentage)
		print("displyalink update to:", percentage, value, currentScore)
		updateLabel(score: value)
	}

	// CAAnimationDelegate
	func animationDidStart(_ anim: CAAnimation) {
		print("did start")
		startDisplayLink()
	}

	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		stopDisplayLink()
		//circleMask.strokeEnd = scoreToArcPercentage(score: currentScore)
//		updateLabel(score: currentScore)
		print("did stop")
//		circleMask.removeAnimation(forKey: "line")
	}



}
