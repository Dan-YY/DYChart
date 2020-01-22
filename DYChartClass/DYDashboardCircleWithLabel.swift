//
//  DYDashboardCircleWithLabel.swift
//  DY2DBodyNodeLib
//
//  Created by macbook on 2020-01-14.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class DYDashboardCircleWithLabel: UIView, DYDashboardCircleDelegate {

	private let circle = DYDashboardCircle()
	private let label = DYComminedLabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {
		addSubview(circle)
		addSubview(label)
		setupView()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	private func setupView() {
//		circle.colorType = .gradient
//		circle.circleType = .circle
//		circle.startPosition = .left
//		circle.value(to: 0, animated: false)
//		circle.frame.size = CGSize(width: 100, height: 100)
//		circle.delegate = self
//
//		label.rootText = "0"
//		label.rootFont = UIFont.systemFont(ofSize: 36, weight: .regular)
//		label.suffixText = "%"
//		label.suffixFont = UIFont.systemFont(ofSize: 22, weight: .regular)
//		label.textColor = .label
//		label.textAlignment = .center
//		label.frame.size = CGSize(width: 100, height: 50)
//		label.center = CGPoint(x: circle.frame.width / 2, y: circle.frame.height / 2)

		circle.frame.size = CGSize(width: 100, height: 100)
		circle.delegate = self
		circle.value(to: 0, animated: false)
		circle.value(to: 0.78, animated: true, duration: 1)
		circle.circleLineWidth = 12

		label.frame.size = CGSize(width: 100, height: 50)
		label.textAlignment = .center
		label.center = CGPoint(x: circle.frame.width / 2, y: circle.frame.height / 2)
		label.rootText = "0"
		label.suffixText = "%"
	}

	func value(to percentage: CGFloat) {
		circle.value(to: percentage, animated: true, duration: 1)
	}

	func circleValueDidUpdate(percentage: CGFloat) {
		let string = String(Int(round(percentage * 1000)))
		label.rootText = string
	}

}
