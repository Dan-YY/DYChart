//
//  DYDashboardCircle.swift
//  DY2DBodyNodeLib
//
//  Created by macbook on 2020-01-13.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

protocol DYDashboardCircleDelegate: class {
	func circleValueDidUpdate(percentage: CGFloat)
}

class DYDashboardCircle: UIView {

	// MARK: Public Circle setting
	weak var delegate: DYDashboardCircleDelegate?
	var circleColors: [UIColor] = [.systemRed, .systemOrange, .systemGreen] { didSet { setNeedsLayout() } }
	var circleLineWidth: CGFloat = 3.0 { didSet { setNeedsLayout() } }
	var colorType: ColorType = .gradient { didSet { setNeedsLayout() } }
	var startPosition: KeyPosition = .left { didSet { setNeedsLayout() } }
	var circleType: CircleType = .circle { didSet { setNeedsLayout() } }

	private(set) var currentValue: CGFloat = 1.0 {
		didSet {
			currentValue = currentValue > 0.0 ? currentValue : 0.0
			currentValue = currentValue < 1.0 ? currentValue : 1.0
		}
	}

	// private var
	private let maskedLayer = CALayer()
	private let circleMask = CAShapeLayer()
	private var displayLink: CADisplayLink?
	private var prevAnimationTimeStampe: Double = 0.0
	private var prevAnimationDuration: Double = 0.0

	// constant and setting
	private let preferredDelegateUpdatesPerSecond = 60
	private let keyPositionToCGPointArray: [CGPoint] = [CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0.0, y: 0.5), CGPoint(x: 0.5, y: 0)]
	private let keyPositionToCenterArray: [CGPoint] = [CGPoint(x: 0.5, y: 0.0), CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0, y: 0.5)]
	private let keyPositionToRadianArray: [CGFloat] = [0.0, CGFloat.pi / 2.0, CGFloat.pi, CGFloat.pi * 1.5 , CGFloat.pi * 2.0]

	// MARK: Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
		fatalError("DYDashboardCircle: init(coder:) has not been implemented")
	}

	private func commonInit() {
		layer.addSublayer(maskedLayer)
	}

	deinit {
		//print("\(self) deinited")
	}

	// MARK: Public func
	func value(to percentage: CGFloat, animated: Bool, duration: TimeInterval? = nil) {
		if animated {
			let duration = duration ?? 0.5
			prevAnimationDuration = duration
			let prevPercentage = currentValue
			currentValue = percentage
			updateCircleWithAnimation(from: prevPercentage, to: currentValue, duration: duration)
		} else {
			updateCircle(to: percentage)
		}
		currentValue = percentage
	}

	// MARK: setup
	override func layoutSubviews() {
		super.layoutSubviews()
		maskedLayer.frame.size = frame.size
		setupMaskedLayer()
		setupMask()
	}

	private func setupMaskedLayer() {
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
				let oppositeSide = startPosition.opposite
				gradient.endPoint = keyPositionToCGPointArray[oppositeSide.rawValue]
				gradient.type = .axial
			}

			gradient.colors = circleColors.map({ $0.cgColor })
			gradient.frame.size = frame.size
			maskedLayer.addSublayer(gradient)

		case .block:
			let radianTotal = circleType.radian
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

	private func setupMask() {
		let startAngle = keyPositionToRadianArray[startPosition.rawValue]
		let endAngle = startAngle + circleType.radian
		let path = makePath(startAngle: startAngle, endAngle: endAngle)
		circleMask.fillColor = UIColor.clear.cgColor
		circleMask.strokeColor = UIColor.white.cgColor
		circleMask.path = path.cgPath
		circleMask.lineWidth = circleLineWidth
		maskedLayer.mask = circleMask
	}
}

// MARK: Local Helper
extension DYDashboardCircle {
	private func makePath(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
		let arcCenter: CGPoint
		let radius: CGFloat

		switch circleType {
		case .circle:
			arcCenter = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
			radius = (min(frame.size.width, frame.size.height) - circleLineWidth) / 2.0
		case .semiCircle:
			let anchor = keyPositionToCenterArray[startPosition.rawValue]
			arcCenter = CGPoint(x: frame.width * anchor.x, y: frame.height * anchor.y)
			switch startPosition {
			case .right, .left:
				radius = min(frame.size.width / 2.0, frame.size.height) - circleLineWidth
			case .bottom, .top:
				radius = min(frame.size.width, frame.size.height / 2.0) - circleLineWidth
			}
		}

		let path = UIBezierPath(arcCenter: arcCenter,
														radius: radius,
														startAngle: startAngle,
														endAngle: endAngle,
														clockwise: true)
		return path
	}

	private func updateCircle(to percentage: CGFloat) {
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		circleMask.strokeEnd = percentage
		CATransaction.commit()
		delegate?.circleValueDidUpdate(percentage: percentage)
	}

	private func updateCircleWithAnimation(from: CGFloat, to: CGFloat, duration: TimeInterval) {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.fromValue = from
		animation.toValue = to
		animation.duration = duration
		circleMask.strokeEnd = to
		circleMask.add(animation, forKey: "drawCircleMask")
		startDisplayLink()
	}
}

// MARK: DisplayLink
extension DYDashboardCircle {
	private func startDisplayLink() {
		guard delegate != nil else { return }
		stopDisplayLink()
		prevAnimationTimeStampe = CACurrentMediaTime()
		displayLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler))
		displayLink?.preferredFramesPerSecond = preferredDelegateUpdatesPerSecond
		displayLink?.add(to: .main, forMode: .common)
	}

	private func stopDisplayLink() {
		displayLink?.invalidate()
		displayLink = nil
		delegate?.circleValueDidUpdate(percentage: currentValue)
	}

	@objc private func displayLinkHandler() {
		guard let progress = circleMask.presentation()?.strokeEnd else {
			return
		}
		delegate?.circleValueDidUpdate(percentage: progress)
		var slapsed = CACurrentMediaTime() - prevAnimationTimeStampe
		if slapsed > prevAnimationDuration {
			stopDisplayLink()
			slapsed = prevAnimationDuration
		}
	}
}

// MARK: Class enum
extension DYDashboardCircle {
	enum ColorType {
		case gradient, block
	}

	enum KeyPosition: Int {
		case right = 0, bottom, left, top
		var opposite: KeyPosition { KeyPosition(rawValue: (rawValue + 2) % 4)! }
	}

	enum CircleType: Int {
		case semiCircle = 0, circle
		var radian: CGFloat { CGFloat(rawValue + 1) * CGFloat.pi }
	}
}

